import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/feature/profile/presentation/profile_screen.dart';
import 'package:quizzerg/feature/profile/presentation/profile_view.dart';
import 'package:zoloto/zoloto.dart';

// --- Mocks ---

class _MockViewModel implements IProfileViewModel {
  _MockViewModel({
    required this.summary,
    this.error,
  });

  @override
  final ProfileSummaryEntity? summary;

  @override
  bool get isLoading => false;

  @override
  final Object? error;

  @override
  void onIdentityTap() {}

  @override
  void onStatsTap() {}

  @override
  void onSettingsTap() {}

  @override
  void onRetryTap() {}
}

// --- Test Data ---

const _summary = ProfileSummaryEntity(
  answersTotal: 278,
  correctTotal: 247,
  accuracyPercent: 89,
  totalCards: 200,
  masteredCount: 142,
  masteredPercent: 71,
  flawlessCount: 120,
  flawlessPercent: 60,
  weakCardsCount: 14,
  currentStreak: 12,
  bestStreak: 21,
  activeDaysCount: 34,
  avgAnswersPerDay: 8.2,
  weekActivity: [true, true, true, true, true, false, false],
  groupsCount: 3,
  testsCount: 19,
);

const _emptySummary = ProfileSummaryEntity(
  answersTotal: 0,
  correctTotal: 0,
  accuracyPercent: 0,
  totalCards: 0,
  masteredCount: 0,
  masteredPercent: 0,
  flawlessCount: 0,
  flawlessPercent: 0,
  weakCardsCount: 0,
  currentStreak: 0,
  bestStreak: 0,
  activeDaysCount: 0,
  avgAnswersPerDay: 0,
  weekActivity: [false, false, false, false, false, false, false],
  groupsCount: 0,
  testsCount: 0,
);

// --- Golden Tests ---

void main() {
  // 1. Сводка с данными
  Zoloto.zolotoTest(
    'profile_with_data',
    widgetBuilder: (context, tester, testCase) => ProfileView(
      viewModel: _MockViewModel(summary: _summary),
    ),
  );

  // 2. Пустое состояние (нет статистики) — нули
  Zoloto.zolotoTest(
    'profile_empty',
    widgetBuilder: (context, tester, testCase) => ProfileView(
      viewModel: _MockViewModel(summary: _emptySummary),
    ),
  );

  // 3. Ошибка загрузки
  Zoloto.zolotoTest(
    'profile_error',
    widgetBuilder: (context, tester, testCase) => ProfileView(
      viewModel: _MockViewModel(summary: null, error: 'boom'),
    ),
  );
}
