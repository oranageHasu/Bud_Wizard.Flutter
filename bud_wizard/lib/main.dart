import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/router-services.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bud Wizard',
        navigatorKey: Get.key,
        initialRoute: uiRouteApp,
        onGenerateRoute: (RouteSettings settings) {
          return determineRoute(settings);
        });
  }
}

class AppBasePage extends StatefulWidget {
  final String title;

  AppBasePage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _AppBasePageState createState() => _AppBasePageState();
}

class _AppBasePageState extends State<AppBasePage> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    // Load any session data, if the app was running and hard refreshed
    initSession();

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      log("App initialized successfully.");
      return LoginPage();
    } else {
      log("App failed to initialize, you rookie.");
      return LoginPage();
    }
  }
}
