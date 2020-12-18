import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/home/homePage.dart';
import 'package:bud_wizard/widgets/login/login.dart';
import 'package:bud_wizard/widgets/navigation%20system/unknownRoutePage.dart';
import 'package:flutter/material.dart';

import '../main.dart';

// This controls the animation between routes
class BudWizardRoute<T> extends MaterialPageRoute<T> {
  BudWizardRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Here, we can add control over the animation length and look/feel
    // For now, I'm just doing a simple transition with no animation
    // More of an SPA feel.  I'm doing animation on load for individual screens
    return child;

    // Fades between routes. (If you don't want any animation, just return child.)
    // return new FadeTransition(opacity: animation, child: child);
  }
}

MaterialPageRoute determineRoute(RouteSettings settings) {
  // This is how routes are handled (by name)
  // This plugs into the BudWizardRoute, which controls the look and feel
  // of screen transitions
  switch (settings.name) {
    case uiRouteApp:
      return new BudWizardRoute(
          builder: (_) => new AppBasePage(), settings: settings);
    case uiRouteHomeScreen:
      return new BudWizardRoute(
          builder: (_) => new HomePage(), settings: settings);
    case uiRouteLogin:
      return new BudWizardRoute(
          builder: (_) => new LoginPage(), settings: settings);
    case uiRouteGrows:
      return new BudWizardRoute(
          builder: (_) => new GrowPage(), settings: settings);
  }

  // Default case
  assert(false);
  return new BudWizardRoute(
      builder: (_) => new UnknownRoutePage(), settings: settings);
}
