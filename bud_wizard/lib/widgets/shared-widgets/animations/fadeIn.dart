import 'package:flutter/material.dart';

class FadeIn extends StatelessWidget {
  final int duration;
  final Widget child;
  final bool visible;

  FadeIn(this.duration, this.child, this.visible);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: duration),
      child: child,
    );
  }
}
