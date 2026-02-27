import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/spacing/width.dart';

class SliverWidth extends StatelessWidget {
  const SliverWidth(this.width, {super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Width(width));
  }
}
