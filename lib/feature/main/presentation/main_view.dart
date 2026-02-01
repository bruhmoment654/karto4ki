import 'package:flutter/material.dart';
import 'package:karto4ki/feature/main/presentation/main_screen.dart';
import 'package:karto4ki/l10n/app_localizations_x.dart';
import 'package:karto4ki/uikit/question_card/question_card.dart';

/// UI layer for main screen.
class MainView extends StatelessWidget {
  final IMainViewModel viewModel;

  const MainView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.navigationMain)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          height: 500,
          child: QuestionCard.fromText(frontText: 'Вопрос', backText: 'Ответ'),
        ),
      ),
    );
  }
}
