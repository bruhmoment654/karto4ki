import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/question_stats/data/converters/question_stats_converter.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/service/i_stats_export_service.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/scoring_calculator.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:quizzerg/persistence/settings/i_settings_storage.dart';

typedef _EnrichedRow = ({
  QuestionStatsEntity stat,
  ScoreComponents components,
  double scoreNoNoise,
  double? accuracy,
  int? daysSinceLastShown,
  int? activeDaysSinceLastShown,
  int ageDays,
  List<String> hostingTestIds,
  List<String> hostingGroupIds,
  int mixupTargetCount,
});

class StatsExportService implements IStatsExportService {
  final QuestionStatsDatabase _questionStatsDatabase;
  final CardsDatabase _cardsDatabase;
  final TestsDatabase _testsDatabase;
  final GroupsDatabase _groupsDatabase;
  final ISettingsStorage _settingsStorage;

  const StatsExportService({
    required QuestionStatsDatabase questionStatsDatabase,
    required CardsDatabase cardsDatabase,
    required TestsDatabase testsDatabase,
    required GroupsDatabase groupsDatabase,
    required ISettingsStorage settingsStorage,
  })  : _questionStatsDatabase = questionStatsDatabase,
        _cardsDatabase = cardsDatabase,
        _testsDatabase = testsDatabase,
        _groupsDatabase = groupsDatabase,
        _settingsStorage = settingsStorage;

  @override
  Future<StatsExportResult> export() async {
    try {
      final statDtos = await _questionStatsDatabase.getAllStats();
      final allCards = await _cardsDatabase.getAllCards();
      if (statDtos.isEmpty && allCards.isEmpty) {
        return const StatsExportEmpty();
      }

      final dirPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Выберите папку для экспорта статистики',
      );
      if (dirPath == null) return const StatsExportCancelled();

      final stats = statDtos.map(QuestionStatsConverter.fromDto).toList();
      final allTests = await _testsDatabase.getAllTests();
      final testTitleById = {for (final test in allTests) test.id: test.title};

      final groupIdsByTestId = <String, List<String>>{};
      for (final test in allTests) {
        groupIdsByTestId[test.id] =
            await _groupsDatabase.getGroupIdsByTestId(test.id);
      }
      final testIdsByGroupId = <String, List<String>>{};
      final allGroups = await _groupsDatabase.getAllGroups();
      for (final group in allGroups) {
        testIdsByGroupId[group.id] =
            await _groupsDatabase.getTestIdsByGroupId(group.id);
      }

      final keysByTestId = <String, Set<String>>{};
      final cardsByKey = <String, List<CardDatabaseDto>>{};
      for (final card in allCards) {
        final key = QuestionKeyNormalizer.normalize(card.question, card.answer);
        keysByTestId.putIfAbsent(card.testId, () => <String>{}).add(key);
        cardsByKey.putIfAbsent(key, () => []).add(card);
      }

      final settings = _settingsStorage.get();
      final weights = ScoringWeights(
        streakNegativeBonus: settings.streakNegativeBonus,
        streakPositivePenalty: settings.streakPositivePenalty,
      );
      final now = DateTime.now();
      final activeDates =
          (await _questionStatsDatabase.getActiveDates()).toSet();

      final enriched = stats
          .map((stat) => _enrich(
                stat: stat,
                weights: weights,
                now: now,
                activeDates: activeDates,
                cardsByKey: cardsByKey,
                keysByTestId: keysByTestId,
                groupIdsByTestId: groupIdsByTestId,
                testIdsByGroupId: testIdsByGroupId,
              ))
          .toList()
        ..sort((rowA, rowB) => rowB.scoreNoNoise.compareTo(rowA.scoreNoNoise));

      final timestamp = _timestamp(now);
      final statsPath = p.join(dirPath, 'question_stats_$timestamp.csv');
      final cardsPath = p.join(dirPath, 'cards_$timestamp.csv');

      await _writeCsv(
        statsPath,
        _statsRows(enriched, weights, activeDates.length),
      );
      await _writeCsv(
        cardsPath,
        _cardsRows(allCards, testTitleById, groupIdsByTestId),
      );

      return StatsExportSuccess(
        statsFilePath: statsPath,
        cardsFilePath: cardsPath,
        questionCount: stats.length,
        cardCount: allCards.length,
      );
    } on Object catch (error) {
      return StatsExportFailure(error.toString());
    }
  }

  _EnrichedRow _enrich({
    required QuestionStatsEntity stat,
    required ScoringWeights weights,
    required DateTime now,
    required Set<DateTime> activeDates,
    required Map<String, List<CardDatabaseDto>> cardsByKey,
    required Map<String, Set<String>> keysByTestId,
    required Map<String, List<String>> groupIdsByTestId,
    required Map<String, List<String>> testIdsByGroupId,
  }) {
    final components = ScoringCalculator.components(
      stat: stat,
      now: now,
      weights: weights,
      activeDates: activeDates,
    );

    final hostingCards = cardsByKey[stat.questionKey] ?? const [];
    final hostingTestIds =
        hostingCards.map((card) => card.testId).toSet().toList()..sort();
    final hostingGroupIds = <String>{};
    for (final testId in hostingTestIds) {
      hostingGroupIds.addAll(groupIdsByTestId[testId] ?? const []);
    }

    final mixupTargetTestIds = <String>{};
    for (final groupId in hostingGroupIds) {
      for (final testId in testIdsByGroupId[groupId] ?? const <String>[]) {
        if (keysByTestId[testId]?.contains(stat.questionKey) ?? false) {
          continue;
        }
        mixupTargetTestIds.add(testId);
      }
    }

    return (
      stat: stat,
      components: components,
      scoreNoNoise: components.weightedSum(weights),
      accuracy: stat.totalShown > 0 ? stat.totalCorrect / stat.totalShown : null,
      daysSinceLastShown: stat.lastShownAt != null
          ? now.difference(stat.lastShownAt!).inDays
          : null,
      activeDaysSinceLastShown:
          stat.lastShownAt != null ? components.activeDaysSinceLastShown : null,
      ageDays: now.difference(stat.createdAt).inDays,
      hostingTestIds: hostingTestIds,
      hostingGroupIds: hostingGroupIds.toList()..sort(),
      mixupTargetCount: mixupTargetTestIds.length,
    );
  }

  List<List<dynamic>> _statsRows(
    List<_EnrichedRow> enriched,
    ScoringWeights weights,
    int totalActiveDays,
  ) {
    final rows = <List<dynamic>>[_statsHeader()];
    for (var index = 0; index < enriched.length; index++) {
      rows.add(_statsRow(enriched[index], index + 1, weights, totalActiveDays));
    }
    return rows;
  }

  List<String> _statsHeader() => const [
        'question_key',
        'front_text',
        'back_text',
        'total_shown',
        'total_correct',
        'total_incorrect',
        'streak',
        'accuracy',
        'created_at',
        'updated_at',
        'last_shown_at',
        'last_answered_at',
        'days_since_last_shown',
        'active_days_since_last_shown',
        'age_days',
        'streak_contribution',
        'decay_factor',
        'new_factor',
        'frequency_factor',
        'score_no_noise',
        'rank_global',
        'in_mixup_pool',
        'hosting_test_ids',
        'hosting_group_ids',
        'mixup_target_test_count',
        'w_streak_negative',
        'w_streak_positive',
        'w_decay',
        'w_new',
        'w_freq',
        'total_active_days',
        'n_active_days_cap',
      ];

  List<dynamic> _statsRow(
    _EnrichedRow row,
    int rank,
    ScoringWeights weights,
    int totalActiveDays,
  ) {
    final stat = row.stat;
    return [
      stat.questionKey,
      stat.frontText,
      stat.backText,
      stat.totalShown,
      stat.totalCorrect,
      stat.totalIncorrect,
      stat.streak,
      row.accuracy ?? '',
      stat.createdAt.toIso8601String(),
      stat.updatedAt.toIso8601String(),
      stat.lastShownAt?.toIso8601String() ?? '',
      stat.lastAnsweredAt?.toIso8601String() ?? '',
      row.daysSinceLastShown ?? '',
      row.activeDaysSinceLastShown ?? '',
      row.ageDays,
      row.components.streakContribution,
      row.components.decayFactor,
      row.components.newFactor,
      row.components.frequencyFactor,
      row.scoreNoNoise,
      rank,
      if (row.mixupTargetCount > 0) 1 else 0,
      row.hostingTestIds.join('|'),
      row.hostingGroupIds.join('|'),
      row.mixupTargetCount,
      weights.streakNegativeBonus,
      weights.streakPositivePenalty,
      weights.decayWeight,
      weights.newWeight,
      weights.freqWeight,
      totalActiveDays,
      ScoringCalculator.kActiveDaysCap,
    ];
  }

  List<List<dynamic>> _cardsRows(
    List<CardDatabaseDto> allCards,
    Map<String, String> testTitleById,
    Map<String, List<String>> groupIdsByTestId,
  ) {
    final rows = <List<dynamic>>[
      const [
        'card_id',
        'test_id',
        'test_title',
        'group_ids',
        'question_key',
        'front',
        'back',
      ],
    ];
    for (final card in allCards) {
      final key = QuestionKeyNormalizer.normalize(card.question, card.answer);
      rows.add([
        card.id,
        card.testId,
        testTitleById[card.testId] ?? '',
        (groupIdsByTestId[card.testId] ?? const <String>[]).join('|'),
        key,
        card.question,
        card.answer,
      ]);
    }
    return rows;
  }

  Future<void> _writeCsv(String path, List<List<dynamic>> rows) async {
    final csv = const ListToCsvConverter().convert(rows);
    await File(path).writeAsString(csv);
  }

  String _two(int value) => value.toString().padLeft(2, '0');

  String _timestamp(DateTime now) =>
      '${now.year}${_two(now.month)}${_two(now.day)}_'
      '${_two(now.hour)}${_two(now.minute)}${_two(now.second)}';
}
