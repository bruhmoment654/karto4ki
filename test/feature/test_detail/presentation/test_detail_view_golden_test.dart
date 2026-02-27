import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/shader/shader_handler.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_screen.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_view.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_type.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/persistence/settings/i_settings_storage.dart';
import 'package:zoloto/zoloto.dart';

// --- Mocks ---

class _MockViewModel implements ITestDetailViewModel {
  @override
  void onAddCardPressed() {}

  @override
  void onCardTapped(CardEntity card) {}

  @override
  void onCardDeletePressed(CardEntity card) {}

  @override
  void onEditTestPressed() {}

  @override
  void onStartTestPressed() {}

  @override
  void onImportCsvPressed() {}

  @override
  void onSwapSidesChanged({required bool value}) {}

  @override
  void onMixupChanged({required bool value}) {}
}

class _MockSettingsStorage implements ISettingsStorage {
  static const _settings = SettingsDto(shaderAnimationEnabled: false);

  @override
  SettingsDto get() => _settings;

  @override
  ValueListenable<SettingsDto> get listenable => ValueNotifier(_settings);

  @override
  void save(SettingsDto dto) {}
}

class _MockAppScope implements IAppScope {
  final _settings = _MockSettingsStorage();

  @override
  ISettingsStorage get settingsStorage => _settings;

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError(
        '${invocation.memberName} is not implemented in _MockAppScope',
      );
}

class _TestFailure extends Failure {
  const _TestFailure({super.message});
}

// --- Test Data ---

final _viewModel = _MockViewModel();
final _appScope = _MockAppScope();

final _testEntity = TestEntity(
  id: '1',
  title: 'English B2',
  type: TestType.tinder,
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

final _testEntityWithDescription = TestEntity(
  id: '1',
  title: 'English B2',
  type: TestType.tinder,
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
  description: 'B2 level vocabulary for exam preparation',
);

final _sampleCards = [
  CardEntity(
    id: '1',
    testId: '1',
    front: 'Apple',
    back: 'Яблоко',
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
  CardEntity(
    id: '2',
    testId: '1',
    front: 'Serendipity',
    back: 'Счастливая случайность',
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
  CardEntity(
    id: '3',
    testId: '1',
    front: 'Ephemeral',
    back: 'Мимолётный, недолговечный',
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
];

// --- Dependencies Wrapper ---

Widget _buildView({
  required TestDetailState state,
  bool swapSides = false,
  bool mixup = false,
}) {
  return Provider<IAppScope>.value(
    value: _appScope,
    child: ShaderScope(
      handler: ShaderHandler.forTesting(),
      child: TestDetailView(
        viewModel: _viewModel,
        state: state,
        swapSides: swapSides,
        mixup: mixup,
      ),
    ),
  );
}

// --- Golden Tests ---

void main() {
  // 1. Loading state
  //
  // TODO(ArcaBoga): uncomment after adding customPump to zolotoTest
  //  (see .claude/ZOLOTO-CUSTOM-PUMP-ISSUE.md).
  //  CircularProgressIndicator — infinite animation, pumpAndSettle hangs.
  //
  // Zoloto.zolotoTest(
  //   'test_detail_loading',
  //   widgetBuilder: (context, tester, testCase) => _buildView(
  //     state: const TestDetailState.loading(),
  //   ),
  //   customPump: (tester) async => tester.pump(),
  // );

  // 2. Error state
  Zoloto.zolotoTest(
    'test_detail_error',
    widgetBuilder: (context, tester, testCase) => _buildView(
      state: const TestDetailState.error(
        failure: _TestFailure(message: 'Test not found'),
      ),
    ),
  );

  // 3. Loaded — empty card list
  Zoloto.zolotoTest(
    'test_detail_loaded_empty',
    widgetBuilder: (context, tester, testCase) => _buildView(
      state: TestDetailState.loaded(
        test: _testEntity,
        cards: const [],
      ),
    ),
  );

  // 4. Loaded — with cards
  Zoloto.zolotoTest(
    'test_detail_loaded_with_cards',
    widgetBuilder: (context, tester, testCase) => _buildView(
      state: TestDetailState.loaded(
        test: _testEntity,
        cards: _sampleCards,
      ),
    ),
  );

  // 5. Loaded — with test description (AppBar bottom)
  Zoloto.zolotoTest(
    'test_detail_loaded_with_description',
    widgetBuilder: (context, tester, testCase) => _buildView(
      state: TestDetailState.loaded(
        test: _testEntityWithDescription,
        cards: _sampleCards,
      ),
    ),
  );

  // 6. Loaded — "swap sides" toggle enabled
  Zoloto.zolotoTest(
    'test_detail_loaded_swap_sides',
    widgetBuilder: (context, tester, testCase) => _buildView(
      state: TestDetailState.loaded(
        test: _testEntity,
        cards: _sampleCards,
      ),
      swapSides: true,
    ),
  );
}
