import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/spacing/height.dart';

class SliverHeight extends StatelessWidget {
  const SliverHeight(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Height(height));
  }
}
