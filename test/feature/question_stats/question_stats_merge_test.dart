import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Серверный снимок не должен обнулять историю, которой сервер не видел:
/// ответы до появления outbox и всё, что приехало из бэкапа старой версии.
void main() {
  late AppDatabase database;
  late QuestionStatsDatabase stats;

  const key = 'вопрос^_ответ';

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    stats = database.questionStatsDatabase;
  });

  tearDown(() => database.close());

  Future<void> insertLocal({
    required int shown,
    required int correct,
    required int incorrect,
    required int streak,
    DateTime? lastAnsweredAt,
  }) => database
      .into(database.questionStats)
      .insert(
        QuestionStatsCompanion.insert(
          questionKey: key,
          frontText: 'вопрос',
          backText: 'ответ',
          streak: Value(streak),
          totalCorrect: Value(correct),
          totalIncorrect: Value(incorrect),
          totalShown: Value(shown),
          lastAnsweredAt: Value(lastAnsweredAt),
          lastShownAt: Value(lastAnsweredAt),
          createdAt: DateTime.utc(2026, 2),
          updatedAt: lastAnsweredAt ?? DateTime.utc(2026, 2),
        ),
      );

  Future<void> applySnapshot({
    required int shown,
    required int correct,
    required int incorrect,
    required int streak,
    DateTime? lastAnsweredAt,
    DateTime? createdAt,
  }) => stats.applyServerSnapshot(
    questionKey: key,
    frontText: 'вопрос',
    backText: 'ответ',
    streak: streak,
    totalCorrect: correct,
    totalIncorrect: incorrect,
    totalShown: shown,
    createdAt: createdAt ?? DateTime.utc(2026, 9),
    updatedAt: DateTime.utc(2026, 9),
    lastAnsweredAt: lastAnsweredAt,
    lastShownAt: lastAnsweredAt,
  );

  test('бедный серверный снимок не затирает локальные счётчики', () async {
    await insertLocal(
      shown: 34,
      correct: 28,
      incorrect: 6,
      streak: 22,
      lastAnsweredAt: DateTime.utc(2026, 9, 5),
    );

    // Сервер знает ровно один ответ — тот, что уехал из outbox после логина.
    await applySnapshot(
      shown: 1,
      correct: 1,
      incorrect: 0,
      streak: 1,
      lastAnsweredAt: DateTime.utc(2026, 9, 6),
    );

    final row = await stats.getByQuestionKey(key);
    expect(row!.totalShown, 34);
    expect(row.totalCorrect, 28);
    expect(row.totalIncorrect, 6);
  });

  test('стрик приезжает из версии со свежим ответом', () async {
    await insertLocal(
      shown: 10,
      correct: 8,
      incorrect: 2,
      streak: 8,
      lastAnsweredAt: DateTime.utc(2026, 9, 5),
    );
    await applySnapshot(
      shown: 3,
      correct: 1,
      incorrect: 2,
      streak: -2,
      lastAnsweredAt: DateTime.utc(2026, 9, 7),
    );

    final row = await stats.getByQuestionKey(key);
    expect(row!.streak, -2);
    expect(row.lastAnsweredAt?.toUtc(), DateTime.utc(2026, 9, 7));
  });

  test('устаревший снимок не двигает стрик и даты назад', () async {
    await insertLocal(
      shown: 10,
      correct: 8,
      incorrect: 2,
      streak: 8,
      lastAnsweredAt: DateTime.utc(2026, 9, 5),
    );
    await applySnapshot(
      shown: 4,
      correct: 4,
      incorrect: 0,
      streak: 4,
      lastAnsweredAt: DateTime.utc(2026, 8),
    );

    final row = await stats.getByQuestionKey(key);
    expect(row!.streak, 8);
    expect(row.lastAnsweredAt?.toUtc(), DateTime.utc(2026, 9, 5));
  });

  test('богатый серверный снимок применяется целиком', () async {
    await insertLocal(
      shown: 5,
      correct: 4,
      incorrect: 1,
      streak: 4,
      lastAnsweredAt: DateTime.utc(2026, 9),
    );
    await applySnapshot(
      shown: 12,
      correct: 9,
      incorrect: 3,
      streak: 2,
      lastAnsweredAt: DateTime.utc(2026, 9, 8),
    );

    final row = await stats.getByQuestionKey(key);
    expect(row!.totalShown, 12);
    expect(row.totalCorrect, 9);
    expect(row.totalIncorrect, 3);
    expect(row.streak, 2);
  });

  test('показов не меньше, чем верных и неверных вместе', () async {
    await insertLocal(shown: 20, correct: 18, incorrect: 2, streak: 5);
    await applySnapshot(shown: 3, correct: 1, incorrect: 12, streak: -1);

    final row = await stats.getByQuestionKey(key);
    expect(row!.totalCorrect, 18);
    expect(row.totalIncorrect, 12);
    expect(row.totalShown, 30);
  });

  test('дата создания берётся самая ранняя', () async {
    await insertLocal(shown: 1, correct: 1, incorrect: 0, streak: 1);
    await applySnapshot(
      shown: 1,
      correct: 1,
      incorrect: 0,
      streak: 1,
      createdAt: DateTime.utc(2025, 12, 31),
    );

    final row = await stats.getByQuestionKey(key);
    expect(row!.createdAt.toUtc(), DateTime.utc(2025, 12, 31));
  });

  test('снимок по незнакомому вопросу вставляется как есть', () async {
    await applySnapshot(
      shown: 7,
      correct: 5,
      incorrect: 2,
      streak: 3,
      lastAnsweredAt: DateTime.utc(2026, 9, 8),
    );

    final row = await stats.getByQuestionKey(key);
    expect(row!.totalShown, 7);
    expect(row.streak, 3);
  });
}
