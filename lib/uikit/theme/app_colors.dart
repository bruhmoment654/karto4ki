import 'dart:ui';

/// Интерфейс цветовой палитры приложения.
abstract class AppColors {
  Color get background;
  Color get card;
  Color get primary;
  Color get secondary;
  Color get muted;
  Color get mutedForeground;
  Color get border;
  Color get accent;
  Color get destructive;
  Color get success;
  Color get warning;
  Color get foreground;
  Color get secondaryForeground;
}

class AppColorsLight implements AppColors {
  const AppColorsLight();

  @override
  Color get background => const Color(0xFFF4F5FA);

  @override
  Color get card => const Color(0xFFFFFFFF);

  @override
  Color get primary => const Color(0xFF5545C4);

  @override
  Color get secondary => const Color(0xFFE8EAF2);

  @override
  Color get muted => const Color(0xFFECEEF5);

  @override
  Color get mutedForeground => const Color(0xFF7A7F96);

  @override
  Color get border => const Color(0xFFDEE2ED);

  @override
  Color get accent => const Color(0xFFF97316);

  @override
  Color get destructive => const Color(0xFFDC2626);

  @override
  Color get success => const Color(0xFF2D9E6B);

  @override
  Color get warning => const Color(0xFFF59E0B);

  @override
  Color get foreground => const Color(0xFF1A1A2E);

  @override
  Color get secondaryForeground => const Color(0xFF4A4E69);
}

class AppColorsDark implements AppColors {
  const AppColorsDark();

  @override
  Color get background => const Color(0xFF0F1117);

  @override
  Color get card => const Color(0xFF1A1E2E);

  @override
  Color get primary => const Color(0xFF6E5FD8);

  @override
  Color get secondary => const Color(0xFF252B3D);

  @override
  Color get muted => const Color(0xFF222638);

  @override
  Color get mutedForeground => const Color(0xFF7A7F9A);

  @override
  Color get border => const Color(0xFF252B3D);

  @override
  Color get accent => const Color(0xFFFB923C);

  @override
  Color get destructive => const Color(0xFF7F1D1D);

  @override
  Color get success => const Color(0xFF38A77A);

  @override
  Color get warning => const Color(0xFFFBBF24);

  @override
  Color get foreground => const Color(0xFFECECF0);

  @override
  Color get secondaryForeground => const Color(0xFFB0B3C5);
}
