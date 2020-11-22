import 'package:flutter/material.dart';

// This controls the animation between routes
// To Do: Move this to its own Service
class BudWizardRoute<T> extends MaterialPageRoute<T> {
  BudWizardRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {

    // Here, we can add control over the animation length and look/feel
    // For now, I'm just doing a simple transition with no animation
    // More of an SPA feel.  I'm doing animation on load for individual screens

    //if (settings.isInitialRoute)
    return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}