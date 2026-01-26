import 'dart:async';

import 'package:flutter/material.dart';

mixin CallbackTimerMixin<T extends StatefulWidget> on State<T> {
  Timer? _timer;

  late int secondsPassed;

  bool isPlaying = false;

  /// Общая длительность таймера.
  int? period = 10;

  abstract final VoidCallback onTimerExpired;

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  void initTimer({Duration duration = const Duration(seconds: 1)}) {
    isPlaying = true;
    secondsPassed = 0;
    _timer = Timer.periodic(duration, (_) => _tick());
  }

  void _tick() {
    if (!isPlaying) return;

    final currentPeriod = period;

    if (currentPeriod != null && secondsPassed >= currentPeriod) {
      onTimerExpired();
      secondsPassed = 0;

      return;
    }
    secondsPassed += 1;
  }

  void pauseTimer() {
    isPlaying = false;
  }

  void restartTimer() {
    isPlaying = true;
    secondsPassed = 0;
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}
