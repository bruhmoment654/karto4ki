import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/question_stats/domain/bloc/question_stats_bloc.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_view.dart';
import 'package:quizzerg/feature/question_stats/presentation/widgets/sort_dialog.dart';

class QuestionStatsScreen extends StatefulWidget {
  const QuestionStatsScreen({super.key});

  @override
  State<QuestionStatsScreen> createState() => _QuestionStatsScreenState();
}

class _QuestionStatsScreenState extends State<QuestionStatsScreen>
    implements IQuestionStatsViewModel {
  /// Порог, после которого показываем кнопку «наверх».
  static const _scrollToTopOffset = 200.0;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _showScrollToTop = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _showScrollToTop.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  StateStreamable<QuestionStatsState> get statsState =>
      context.read<QuestionStatsBloc>();

  @override
  TextEditingController get searchController => _searchController;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  ValueListenable<bool> get showScrollToTop => _showScrollToTop;

  void _onScroll() {
    _showScrollToTop.value = _scrollController.offset > _scrollToTopOffset;
  }

  @override
  void onSearchChanged(String value) {
    context.read<QuestionStatsBloc>().add(
          QuestionStatsEvent.searchChanged(query: value),
        );
  }

  @override
  void onSearchCleared() {
    _searchController.clear();
    context.read<QuestionStatsBloc>().add(
          const QuestionStatsEvent.searchCleared(),
        );
  }

  @override
  void onRetryTap() {
    context.read<QuestionStatsBloc>().add(const QuestionStatsEvent.started());
  }

  @override
  Future<void> onSortTap() async {
    final bloc = context.read<QuestionStatsBloc>();
    final state = bloc.state;
    if (state is! QuestionStatsState$Loaded) return;

    final selected = await showSortDialog(
      context: context,
      currentSort: state.sort,
    );
    if (selected == null) return;

    bloc.add(QuestionStatsEvent.sortChanged(sort: selected));
  }

  @override
  void onSortOrderTap() {
    context.read<QuestionStatsBloc>().add(
          const QuestionStatsEvent.sortOrderToggled(),
        );
  }

  @override
  void onScrollToTopTap() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuestionStatsView(viewModel: this);
  }
}

/// Контракт взаимодействия [QuestionStatsScreen] и [QuestionStatsView].
abstract interface class IQuestionStatsViewModel {
  /// Статистика: загрузка, список, ошибка, параметры поиска и сортировки.
  StateStreamable<QuestionStatsState> get statsState;

  ScrollController get scrollController;
  TextEditingController get searchController;

  /// Показывать ли кнопку «наверх» — локальное состояние скролла.
  ValueListenable<bool> get showScrollToTop;

  void onRetryTap();
  Future<void> onSortTap();
  void onSortOrderTap();
  void onScrollToTopTap();
  void onSearchChanged(String value);
  void onSearchCleared();
}
