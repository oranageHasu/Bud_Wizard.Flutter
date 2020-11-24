import 'package:bud_wizard/services/router-services.dart';
import 'package:bud_wizard/widgets/grow/growsPage.dart';
import 'package:bud_wizard/widgets/login/login.dart';
import 'package:bud_wizard/widgets/plant/plantPage.dart';
import 'package:bud_wizard/widgets/plant/plantsPage.dart';

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

import 'classes/constants.dart';

void main() {
  runApp(MyApp());
}

// App color scheme
Map<int, Color> color =
{
  50:Color.fromRGBO(0, 128, 43, .1),
  100:Color.fromRGBO(0, 128, 43, .2),
  200:Color.fromRGBO(0, 128, 43, .3),
  300:Color.fromRGBO(0, 128, 43, .4),
  400:Color.fromRGBO(0, 128, 43, .5),
  500:Color.fromRGBO(0, 128, 43, .6),
  600:Color.fromRGBO(0, 128, 43, .7),
  700:Color.fromRGBO(0, 128, 43, .8),
  800:Color.fromRGBO(0, 128, 43, .9),
  900:Color.fromRGBO(0, 128, 43, 1),
};

// The App's base color
MaterialColor colorCustom = MaterialColor(0xFF29cf61, color);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bud Wizard',
      theme: ThemeData(
        primarySwatch: colorCustom,
        bottomAppBarColor: colorCustom,
        hoverColor: Colors.black38,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {

        // This is how routes are handled (by name)
        // This plugs into the BudWizardRoute, which controls the look and feel
        // of screen transitions
        switch (settings.name) {
          case uiRouteHome: return new BudWizardRoute(
            builder: (_) => new HomePage(),
            settings: settings,
          );
          case uiRouteLogin: return new BudWizardRoute(
            builder: (_) => new LoginPage(),
            settings: settings,
          );
          case uiRouteGrows: return new BudWizardRoute(
            builder: (_) => new GrowsPage(),
            settings: settings,
          );
          case uiRoutePlants: return new BudWizardRoute(
            builder: (_) => new PlantsPage(),
            settings: settings,
          );
          case uiRoutePlant: return new BudWizardRoute(
            builder: (_) => new PlantPage(),
            settings: settings,
          );
        }

        // Default case
        // To Do: Make this an error page
        assert(false);
        return new BudWizardRoute(
          builder: (_) => new HomePage(),
          settings: settings,
        );
      }
    );
  }

}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of Bud Wizard. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      print("An error occurred initializing Firebase.");
      return GrowsPage();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print("Firebase initialization failed.");
      return GrowsPage();
    }

    print("App initialized successfully.");
    return LoginPage();
  }
}