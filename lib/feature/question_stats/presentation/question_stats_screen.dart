import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_view.dart';

class QuestionStatsScreen extends StatefulWidget {
  const QuestionStatsScreen({super.key});

  @override
  State<QuestionStatsScreen> createState() => _QuestionStatsScreenState();
}

class _QuestionStatsScreenState extends State<QuestionStatsScreen>
    implements IQuestionStatsViewModel {
  List<QuestionStatsEntity>? _stats;
  bool _isLoading = true;
  Object? _error;

  @override
  List<QuestionStatsEntity>? get stats => _stats;

  @override
  bool get isLoading => _isLoading;

  @override
  Object? get error => _error;

  @override
  void initState() {
    super.initState();
    _loadStats();
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
          _stats = data;
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
  Widget build(BuildContext context) {
    return QuestionStatsView(viewModel: this);
  }
}

abstract interface class IQuestionStatsViewModel {
  List<QuestionStatsEntity>? get stats;
  bool get isLoading;
  Object? get error;
  void onRetryTap();
}
