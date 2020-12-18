import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/services/router-services.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/login/login.dart';

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bud Wizard',
        theme: ThemeData(
          primarySwatch: appBaseColor,
          bottomAppBarColor: appBaseColor,
          hoverColor: Colors.black38,
        ),
        initialRoute: uiRouteApp,
        onGenerateRoute: (RouteSettings settings) {
          return determineRoute(settings);
        });
  }
}

class AppBasePage extends StatefulWidget {
  AppBasePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of Bud Wizard. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AppBasePageState createState() => _AppBasePageState();
}

class _AppBasePageState extends State<AppBasePage> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    initializeFlutterFire();

    // Load any session data, if the app was running and hard refreshed
    initSession();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print("An error occurred initializing Firebase.");
      return GrowPage();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print("Firebase initialization failed.");
      return GrowPage();
    }

    print("App initialized successfully.");
    return LoginPage();
  }
}
