import 'dart:async';

import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final int duration;
  final Duration delay;
  final Widget child;
  final bool isVisible;

  FadeIn({
    @required int duration,
    @required Widget child,
    @required bool isVisible,
    Duration delay = const Duration(milliseconds: 0),
  })  : this.duration = duration,
        this.delay = delay,
        this.child = child,
        this.isVisible = isVisible;

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  bool _shouldActivate = false;
  Timer _delayTimer;

  @override
  void initState() {
    super.initState();

    _delayTimer = Timer(widget.delay, displayContent);
  }

  @override
  void dispose() {
    super.dispose();

    _delayTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isVisible && _shouldActivate ? 1.0 : 0.0,
      duration: Duration(milliseconds: widget.duration),
      child: widget.child,
    );
  }

  void displayContent() {
    _delayTimer.cancel();

    setState(() {
      _shouldActivate = !_shouldActivate;
    });
  }
}
