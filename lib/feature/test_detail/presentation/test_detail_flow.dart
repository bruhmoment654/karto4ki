import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/csv_import_bloc.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_screen.dart';

/// Entry point for test detail screen.
///
/// This Flow provides [TestDetailBloc] and [CsvImportBloc] for the entire
/// test detail screen subtree.
@RoutePage()
class TestDetailFlow extends StatelessWidget implements AutoRouteWrapper {
  final String testId;
  final bool mixup;
  final int mixupMin;
  final int mixupMax;

  /// Группа, из которой открыт тест; передаётся в запуск теста.
  final String? groupId;

  /// Сразу после загрузки открыть импорт карточек (действие «Импорт
  /// карточек» из шторки теста в деталке группы).
  final bool openImport;

  const TestDetailFlow({
    @PathParam('testId') required this.testId,
    this.mixup = false,
    this.mixupMin = 1,
    this.mixupMax = 5,
    this.groupId,
    this.openImport = false,
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TestDetailBloc(
            repository: scope.testDetailRepository,
            syncSignal: scope.syncSignalRepository,
          )..add(TestDetailEvent.started(testId: testId)),
        ),
        BlocProvider(
          create: (_) => CsvImportBloc(
            csvImportService: scope.csvImportService,
          ),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TestDetailScreen(
      mixup: mixup,
      mixupMin: mixupMin,
      mixupMax: mixupMax,
      groupId: groupId,
      openImport: openImport,
    );
  }
}
