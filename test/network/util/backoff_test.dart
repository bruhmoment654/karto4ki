import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/network/util/backoff.dart';

void main() {
  group('Backoff', () {
    test('растёт экспоненциально', () {
      final random = Random(1);
      final first = Backoff.delayFor(1, random: random);
      final third = Backoff.delayFor(3, random: random);

      expect(third, greaterThan(first));
    });

    test('не превышает потолок', () {
      for (var attempt = 1; attempt <= 20; attempt++) {
        expect(
          Backoff.delayFor(attempt),
          lessThanOrEqualTo(Backoff.defaultMax),
        );
      }
    });

    test('джиттер не даёт нулевой задержки', () {
      for (var attempt = 1; attempt <= 10; attempt++) {
        expect(Backoff.delayFor(attempt), greaterThan(Duration.zero));
      }
    });

    test('джиттер разносит попытки', () {
      final delays = List.generate(
        20,
        (_) => Backoff.delayFor(4).inMilliseconds,
      ).toSet();

      expect(delays.length, greaterThan(1));
    });
  });
}
