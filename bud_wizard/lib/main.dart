import 'package:bud_wizard/widgets/growCard.dart';
import 'package:bud_wizard/widgets/screenHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:simple_animations/simple_animations.dart';

void main() {
  runApp(MyApp());
}

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

MaterialColor colorCustom = MaterialColor(0xFF00802b, color);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bud Wizard',
      theme: ThemeData(
        primarySwatch: colorCustom,
        bottomAppBarColor: colorCustom,
        hoverColor: Colors.lightGreen[100],
      ),
      home: HomePage(title: 'Bud Wizard'),
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
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    final emailField = Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 600),
      child: TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      )
    );

    final passwordField = Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 600),
      child: TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      )
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF00802b),
      child: MaterialButton(
        minWidth: 200.0,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () { print("To Do - Handle Login"); },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "budwizard_logo_400x400.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
class _GrowsPageState extends State<GrowsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              FadeIn(1.0, ScreenHeader()),
              //WhitespaceSeparator(),
              FadeIn(3.0, GrowCard()),
              FadeIn(3.5, GrowCard()),
              FadeIn(4.0, GrowCard()),
            ],
          ),
          color: Colors.grey[100],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Oranagehasu"),
              accountEmail: Text("Oranagehasu@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("Image"),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("plant"),
                )
              ],
            ),
            ListTile(
              title: new Text("Messages"),
              leading: new Icon(Icons.mail),
            ),
            Divider(
              height: 0.1,
            ),
            ListTile(
              title: new Text("Grows"),
              leading: new Icon(Icons.inbox),
            ),
            ListTile(
              title: new Text("Social"),
              leading: new Icon(Icons.people),
            ),
            ListTile(
              title: new Text("Knowledge Base"),
              leading: new Icon(Icons.info),
            ),
            ListTile(
              title: new Text("Settings"),
              leading: new Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }
}
*/

class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeIn(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateX").add(
          Duration(milliseconds: 500), Tween(begin: 130.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(animation["translateX"], 0), child: child),
      ),
    );
  }
}
