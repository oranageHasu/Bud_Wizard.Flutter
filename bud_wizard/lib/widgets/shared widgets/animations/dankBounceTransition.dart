import 'package:flutter/material.dart';

enum SlideTransitionType {
  SlideDown,
  SlideLeftToRight,
}

class DankBounceTransition extends StatefulWidget {
  final Widget child;
  final SlideTransitionType slideType;

  DankBounceTransition({
    @required Widget child,
    @required SlideTransitionType slideType,
  })  : this.child = child,
        this.slideType = slideType;

  @override
  _DankBounceTransitionState createState() => _DankBounceTransitionState();
}

class _DankBounceTransitionState extends State<DankBounceTransition>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 350),
      vsync: this,
    )..forward();

    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    switch (widget.slideType) {
      case SlideTransitionType.SlideDown:
        _animation = Tween<Offset>(
          begin: const Offset(0.0, -0.25),
          end: const Offset(0.0, 0.0),
        ).animate(curvedAnimation);
        break;

      case SlideTransitionType.SlideLeftToRight:
        _animation = Tween<Offset>(
          begin: const Offset(-0.25, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(curvedAnimation);
        break;
    }
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
