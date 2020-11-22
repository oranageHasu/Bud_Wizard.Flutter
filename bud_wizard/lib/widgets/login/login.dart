import 'package:bud_wizard/models/grow.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Grow> _grows;

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
        onPressed: () async {

            // To Do: Authenticate the login here

            Navigator.pushReplacementNamed(
              context,
              '/Grows'
            );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Material(
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
    );
  }
}



