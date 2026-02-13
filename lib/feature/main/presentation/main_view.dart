import 'package:flutter/material.dart';
import 'package:quizzerg/feature/main/presentation/main_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/question_card/question_card.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

/// UI layer for main screen.
class MainView extends StatelessWidget {
  final IMainViewModel viewModel;

  const MainView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: Karto4kiAppBar(title: context.l10n.navigationMain),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          height: 500,
          child: QuestionCard.fromText(
            frontText: context.l10n.mainQuestionCardFront,
            backText: context.l10n.mainQuestionCardBack,
          ),
        ),
      ),
    );
  }
}

