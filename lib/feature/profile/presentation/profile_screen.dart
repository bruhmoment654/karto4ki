import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/feature/profile/domain/profile_stats_calculator.dart';
import 'package:quizzerg/feature/profile/presentation/profile_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements IProfileViewModel {
  ProfileSummaryEntity? _summary;
  bool _isLoading = true;
  Object? _error;

  @override
  ProfileSummaryEntity? get summary => _summary;

  @override
  bool get isLoading => _isLoading;

  @override
  Object? get error => _error;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final scope = context.read<IAppScope>();
    final statsResult = await scope.questionStatsRepository.getAllStats();
    final datesResult = await scope.questionStatsRepository.getActiveDates();
    final groupsResult = await scope.groupsListRepository.getGroups();
    final testsResult = await scope.testsListRepository.getTests();

    if (!mounted) return;

    switch ((statsResult, datesResult, groupsResult, testsResult)) {
      case (
          ResultOk(data: final stats),
          ResultOk(data: final dates),
          ResultOk(data: final groups),
          ResultOk(data: final tests),
        ):
        setState(() {
          _isLoading = false;
          _summary = ProfileStatsCalculator.calculate(
            stats: stats,
            activeDates: dates,
            today: DateTime.now(),
            groupsCount: groups.length,
            testsCount: tests.length,
          );
        });
      case _:
        setState(() {
          _isLoading = false;
          _error = _firstError([
                statsResult,
                datesResult,
                groupsResult,
                testsResult,
              ]) ??
              Exception('Unknown error');
        });
    }
  }

  Object? _firstError(List<Result<Object?, Object>> results) {
    for (final result in results) {
      if (result case ResultFailed(:final error)) return error;
    }
    return null;
  }

  @override
  void onIdentityTap() {
    // Вкладки Home: 0 — главная, 1 — статистика, 2 — профиль.
    context.tabsRouter.setActiveIndex(0);
  }

  @override
  void onStatsTap() {
    context.tabsRouter.setActiveIndex(1);
  }

  @override
  void onSettingsTap() {
    context.router.push(const SettingsRoute());
  }

  @override
  void onRetryTap() {
    _loadSummary();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(viewModel: this);
  }
}

abstract interface class IProfileViewModel {
  ProfileSummaryEntity? get summary;
  bool get isLoading;
  Object? get error;
  void onIdentityTap();
  void onStatsTap();
  void onSettingsTap();
  void onRetryTap();
}
