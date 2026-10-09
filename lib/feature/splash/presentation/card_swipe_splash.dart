import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quizzerg/feature/splash/presentation/card_back.dart';

/// Цвет сплеша. Должен совпадать с `flutter_native_splash.color`
/// (`flutter_native_splash.yaml`) для бесшовного перехода native → Flutter.
const kSplashColor = Color(0xFF4A2FB0);

/// {@template card_swipe_splash.class}
/// Враппер анимированного сплеша поверх контента приложения.
///
/// Нативный сплеш заливает экран сплошным [kSplashColor]. Когда управление
/// переходит во Flutter, [CardSwipeSplash] рисует тот же цвет на весь экран
/// (бесшовный стык), затем заливка сжимается в скруглённую карту: параллельно
/// со сжатием на ней проявляется и прочерчивается рубашка ([CardBack]), после
/// чего карта смахивается вбок — открывая [child] под собой.
///
/// Пока оверлей перекрывает экран, [child] спокойно инициализируется —
/// свайп открывает уже готовый контент.
/// {@endtemplate}
class CardSwipeSplash extends StatefulWidget {
  /// Контент, который находится под сплешом и открывается свайпом.
  final Widget child;

  /// Колбэк по завершению анимации (оверлей полностью ушёл за край).
  final VoidCallback? onFinished;

  /// Длительность анимации свайпа.
  final Duration duration;

  /// Направление свайпа: `true` — вправо, `false` — влево.
  final bool swipeRight;

  /// {@macro card_swipe_splash.class}
  const CardSwipeSplash({
    required this.child,
    this.onFinished,
    this.duration = const Duration(milliseconds: 1350),
    this.swipeRight = true,
    super.key,
  });

  @override
  State<CardSwipeSplash> createState() => _CardSwipeSplashState();
}

class _CardSwipeSplashState extends State<CardSwipeSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  /// Оверлей полностью ушёл за край — перестаём его рисовать.
  final ValueNotifier<bool> _isGone = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _finish();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Reduced-motion: сразу убираем оверлей без анимации.
      if (MediaQuery.of(context).disableAnimations) {
        _finish();
      } else {
        _controller.forward();
      }
    });
  }

  void _finish() {
    _isGone.value = true;
    widget.onFinished?.call();
  }

  @override
  void dispose() {
    _isGone.dispose();
    _controller.dispose();
    super.dispose();
  }

  /// Прогресс сегмента `[from; to]` внутри общего таймлайна, с кривой [curve].
  double _segment(double value, double from, double to, Curve curve) =>
      curve.transform(((value - from) / (to - from)).clamp(0.0, 1.0));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Доступен внутри builder MaterialApp: тот оборачивает builder в Builder
    // под AnimatedTheme, поэтому Theme.of резолвится в актуальную тему.
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        widget.child,
        ValueListenableBuilder<bool>(
          valueListenable: _isGone,
          builder: (context, isGone, child) => isGone
              ? const SizedBox.shrink()
              : child ?? const SizedBox.shrink(),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final value = _controller.value;
              // Сжатие в карту.
              final shrink = _segment(value, 0, 0.34, Curves.easeInOutCubic);
              // Рубашка стартует вместе со сжатием и прочерчивается раньше,
              // чем сжатие завершится.
              final appear = _segment(value, 0, 0.18, Curves.easeOut);
              final lattice = _segment(value, 0.04, 0.5, Curves.easeOut);
              // Микро-«замах» перед свайпом.
              final wind = _segment(value, 0.5, 0.6, Curves.easeOut);
              // Смах за край.
              final swipe = _segment(value, 0.6, 1, Curves.easeInCubic);

              // Перекрас брендового фиолетового в акцент темы (primary) по
              // мере сжатия: к моменту, когда карта сжата и вот-вот поедет,
              // она целиком в акценте, как остальные акцентные элементы.
              // На старте (shrink == 0) — kSplashColor для бесшовного стыка
              // с нативным сплешом. Решётка — onPrimary, как контент на
              // filled-кнопке: на светлом акценте тёмной темы белая теряется.
              final baseColor =
                  Color.lerp(kSplashColor, colorScheme.primary, shrink) ??
                      colorScheme.primary;
              final lineColor =
                  Color.lerp(Colors.white, colorScheme.onPrimary, shrink) ??
                      colorScheme.onPrimary;

              final scale = 1.0 - 0.38 * shrink; // 1 → 0.62
              final radius = 44.0 * shrink; // 0 → 44
              // Размеры карты: от полноэкранных (бесшовный старт) к пропорции
              // 3:4 (как у карточек теста) по мере сжатия.
              final cardWidth = size.width;
              final cardHeight =
                  size.height + (size.width * 4 / 3 - size.height) * shrink;
              final dir = widget.swipeRight ? 1.0 : -1.0;
              final dx = dir * swipe * size.width * 1.5; // за край экрана
              final angle = (-4.0 * wind + 20.0 * swipe) * math.pi / 180 * dir;

              return Positioned.fill(
                child: Transform.translate(
                  offset: Offset(dx, 0),
                  child: Transform.rotate(
                    angle: angle,
                    child: Center(
                      child: Transform.scale(
                        scale: scale,
                        child: SizedBox(
                          width: cardWidth,
                          height: cardHeight,
                          child: _SplashCard(
                            radius: radius,
                            draw: lattice,
                            appear: appear,
                            baseColor: baseColor,
                            lineColor: lineColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Карта сплеша: плоский [baseColor] во весь экран на старте (бесшовный стык
/// с нативным сплешом), поверх по мере сжатия проявляется рубашка ([CardBack]),
/// решётка которой прочерчивается через [draw]. При сжатии добавляется
/// тень-приподнятость. [baseColor] перетекает из брендового фиолетового в цвет
/// темы по мере сжатия.
class _SplashCard extends StatelessWidget {
  /// Радиус скругления углов карты.
  final double radius;

  /// Прогресс прочерчивания решётки рубашки `[0; 1]`.
  final double draw;

  /// Прогресс проявления рубашки `[0; 1]` (плавно поверх плоского цвета).
  final double appear;

  /// Сплошной цвет карты — и заливки, и фона рубашки.
  final Color baseColor;

  /// Цвет линий решётки рубашки.
  final Color lineColor;

  const _SplashCard({
    required this.radius,
    required this.draw,
    required this.appear,
    required this.baseColor,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: radius > 4
            ? const [
                BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 30,
                  offset: Offset(0, 18),
                ),
              ]
            : null,
      ),
      child: Opacity(
        opacity: appear,
        child: CardBack(
          draw: draw,
          radius: radius,
          color: baseColor,
          lineColor: lineColor,
        ),
      ),
    );
  }
}
