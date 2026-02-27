import 'package:flutter/material.dart';

class Height extends StatelessWidget {
  const Height(this.height, {this.child, super.key});

  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, child: child);
  }
}
