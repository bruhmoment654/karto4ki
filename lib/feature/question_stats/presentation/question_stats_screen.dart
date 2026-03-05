import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_sort.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_view.dart';
import 'package:quizzerg/feature/question_stats/presentation/widgets/sort_dialog.dart';

class QuestionStatsScreen extends StatefulWidget {
  const QuestionStatsScreen({super.key});

  @override
  State<QuestionStatsScreen> createState() => _QuestionStatsScreenState();
}

class _QuestionStatsScreenState extends State<QuestionStatsScreen>
    implements IQuestionStatsViewModel {
  List<QuestionStatsEntity>? _rawStats;
  bool _isLoading = true;
  Object? _error;

  QuestionStatsSort _sort = QuestionStatsSort.byDate;
  SortOrder _sortOrder = SortOrder.descending;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  List<QuestionStatsEntity>? get stats {
    final raw = _rawStats;
    if (raw == null) return null;
    return _sortedStats(raw);
  }

  @override
  bool get isLoading => _isLoading;

  @override
  Object? get error => _error;

  @override
  QuestionStatsSort get currentSort => _sort;

  @override
  SortOrder get sortOrder => _sortOrder;

  @override
  bool get showScrollToTop => _showScrollToTop;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadStats();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShow = _scrollController.offset > 200;
    if (shouldShow != _showScrollToTop) {
      setState(() => _showScrollToTop = shouldShow);
    }
  }

  List<QuestionStatsEntity> _sortedStats(List<QuestionStatsEntity> stats) {
    final sorted = List<QuestionStatsEntity>.of(stats)
      ..sort((a, b) {
        final cmp = switch (_sort) {
          QuestionStatsSort.byDate => a.updatedAt.compareTo(b.updatedAt),
          QuestionStatsSort.byStreak => a.streak.compareTo(b.streak),
          QuestionStatsSort.byAccuracy => _accuracy(a).compareTo(_accuracy(b)),
        };
        return _sortOrder == SortOrder.ascending ? cmp : -cmp;
      });
    return sorted;
  }

  double _accuracy(QuestionStatsEntity stat) {
    final total = stat.totalCorrect + stat.totalIncorrect;
    if (total == 0) return 0;
    return stat.totalCorrect / total;
  }

  Future<void> _loadStats() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result =
        await context.read<IAppScope>().questionStatsRepository.getAllStats();

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      switch (result) {
        case ResultOk(:final data):
          _rawStats = data;
        case ResultFailed(:final error):
          _error = error;
      }
    });
  }

  @override
  void onRetryTap() {
    _loadStats();
  }

  @override
  Future<void> onSortTap() async {
    final selected = await showSortDialog(
      context: context,
      currentSort: _sort,
    );
    if (selected != null && selected != _sort && mounted) {
      setState(() {
        _sort = selected;
        _sortOrder = SortOrder.ascending;
      });
    }
  }

  @override
  void onSortOrderTap() {
    setState(() {
      _sortOrder = _sortOrder == SortOrder.ascending
          ? SortOrder.descending
          : SortOrder.ascending;
    });
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

abstract interface class IQuestionStatsViewModel {
  List<QuestionStatsEntity>? get stats;
  bool get isLoading;
  Object? get error;
  QuestionStatsSort get currentSort;
  SortOrder get sortOrder;
  bool get showScrollToTop;
  ScrollController get scrollController;
  void onRetryTap();
  void onSortTap();
  void onSortOrderTap();
  void onScrollToTopTap();
}
