import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_replay.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/buttons/karto4ki_button.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/motion/count_up_text.dart';
import 'package:quizzerg/uikit/motion/fade_in.dart';
import 'package:quizzerg/uikit/motion/staggered_appear.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Анимации и кривые движения.
class MotionSection extends StatelessWidget {
  const MotionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CatalogItem(
          title: 'FadeIn',
          description: 'Проявление со сдвигом снизу',
          child: CatalogReplay(
            child: FadeIn(child: ContentCard(child: Text('Появился'))),
          ),
        ),
        const CatalogItem(
          title: 'StaggeredAppear',
          description: 'Каскадное появление, нужен AnimationLimiter',
          child: CatalogReplay(child: _StaggeredList()),
        ),
        CatalogItem(
          title: 'CountUpText',
          child: CatalogReplay(
            child: CountUpText(
              value: 1234,
              suffix: ' карточек',
              style: textTheme.headlineMedium,
            ),
          ),
        ),
        const CatalogItem(
          title: 'AppMotion',
          description: 'Кривые emphasized и spring',
          child: _CurvesDemo(),
        ),
      ],
    );
  }
}

class _StaggeredList extends StatelessWidget {
  const _StaggeredList();

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: [
          for (var index = 0; index < 4; index++)
            StaggeredAppear(
              position: index,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ContentCard(child: Text('Элемент ${index + 1}')),
              ),
            ),
        ],
      ),
    );
  }
}

class _CurvesDemo extends StatefulWidget {
  const _CurvesDemo();

  @override
  State<_CurvesDemo> createState() => _CurvesDemoState();
}

class _CurvesDemoState extends State<_CurvesDemo> {
  bool _isEnd = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CurveTrack(
          label: 'emphasized',
          curve: AppMotion.emphasized,
          isEnd: _isEnd,
        ),
        const Height(8),
        _CurveTrack(label: 'spring', curve: AppMotion.spring, isEnd: _isEnd),
        const Height(8),
        Karto4kiButton(
          label: 'Запустить',
          icon: Icons.play_arrow,
          variant: Karto4kiButtonVariant.ghost,
          onPressed: () => setState(() => _isEnd = !_isEnd),
        ),
      ],
    );
  }
}

class _CurveTrack extends StatelessWidget {
  final String label;
  final Curve curve;
  final bool isEnd;

  const _CurveTrack({
    required this.label,
    required this.curve,
    required this.isEnd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimens.radius20),
      ),
      child: AnimatedAlign(
        alignment: isEnd ? Alignment.centerRight : Alignment.centerLeft,
        duration: AppMotion.medium,
        curve: curve,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(AppDimens.radius16),
          ),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
