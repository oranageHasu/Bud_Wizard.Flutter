import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final int duration;
  final Widget child;
  final bool visible;

  FadeIn(
    this.duration,
    this.child,
    this.visible,
  );

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  bool _shouldActivate = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => displayContent(context));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.visible && _shouldActivate ? 1.0 : 0.0,
      duration: Duration(milliseconds: widget.duration),
      child: widget.child,
    );
  }

  void displayContent(BuildContext context) {
    setState(() {
      _shouldActivate = !_shouldActivate;
    });
  }
}
