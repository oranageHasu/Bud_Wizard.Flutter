import 'package:bud_wizard/widgets/shared%20widgets/animations/dankSlideUpTransition.dart';
import 'package:flutter/material.dart';

class DankSlideIn extends StatefulWidget {
  final Widget child;
  final bool isVisible;

  DankSlideIn({
    @required Widget child,
    @required bool isVisible,
  })  : this.child = child,
        this.isVisible = isVisible;

  @override
  _DankSlideInState createState() => _DankSlideInState();
}

class _DankSlideInState extends State<DankSlideIn>
    with SingleTickerProviderStateMixin {
  SlideUpController _slideUpController = SlideUpController();
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(-0.2, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          // Start animation at begin
          _slideUpController.toggle();
        } else if (status == AnimationStatus.dismissed) {
          // To hide widget, we need complete animation first
          _slideUpController.toggle();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  void didUpdateWidget(DankSlideIn oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isVisible != widget.isVisible) {
      if (_controller.isDismissed) {
        print('forward');
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: DankSlideUpTransition(
        controller: _slideUpController,
        child: widget.child,
      ),
    );
  }
}
