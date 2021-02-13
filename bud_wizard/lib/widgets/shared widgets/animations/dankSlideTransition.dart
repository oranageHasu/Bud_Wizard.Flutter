import 'package:flutter/material.dart';

class DankSlideTransition extends StatefulWidget {
  final Widget child;

  DankSlideTransition({
    @required Widget child,
  }) : this.child = child;

  @override
  _DankSlideTransitionState createState() => _DankSlideTransitionState();
}

class _DankSlideTransitionState extends State<DankSlideTransition>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.0, -0.25),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      transformHitTests: true,
      child: widget.child,
    );
  }
}
