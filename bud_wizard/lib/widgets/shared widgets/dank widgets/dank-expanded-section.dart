import 'package:flutter/material.dart';

class DankExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;

  DankExpandedSection({
    @required this.expand,
    @required this.child,
  });

  @override
  _DankExpandedSectionState createState() => _DankExpandedSectionState(
        this.expand,
        this.child,
      );
}

class _DankExpandedSectionState extends State<DankExpandedSection>
    with SingleTickerProviderStateMixin {
  Widget child;
  bool expand;
  AnimationController _expandController;
  Animation<double> _animation;

  _DankExpandedSectionState(
    this.expand,
    this.child,
  );

  @override
  void initState() {
    super.initState();

    _prepareAnimations();
    _runExpandCheck();
  }

  @override
  void didUpdateWidget(DankExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    _runExpandCheck();
  }

  @override
  void dispose() {
    _expandController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: _animation,
      child: child,
    );
  }

  void _prepareAnimations() {
    _expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }
}
