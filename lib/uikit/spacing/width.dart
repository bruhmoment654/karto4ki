import 'package:flutter/material.dart';

class Width extends StatelessWidget {
  const Width(this.width, {this.child, super.key});

  final double width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: child);
  }
}
