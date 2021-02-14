import 'package:flutter/material.dart';

class DankSizeTransition extends StatefulWidget {
  final Widget child;
  final bool isVisible;

  DankSizeTransition({
    @required Widget child,
    @required bool isVisible,
  })  : this.child = child,
        this.isVisible = isVisible;

  @override
  _DankSizeTransitionState createState() => _DankSizeTransitionState();
}

class _DankSizeTransitionState extends State<DankSizeTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.horizontal,
      axisAlignment: -1,
      child: widget.child,
    );
  }
}
