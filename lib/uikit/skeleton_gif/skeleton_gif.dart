import 'package:flutter/material.dart';
import 'package:quizzerg/gen/assets.gen.dart';

class SkeletonGif extends StatelessWidget {
  final double? height;

  const SkeletonGif({this.height = 120, super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.icons.skeletonDanceSkelly.image(height: height);
  }
}
