import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/shared-widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared-widgets/dank%20widgets/dank-textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode passwordFocusNode = new FocusNode();
  bool _isLoading = false;
  bool _failedLogin = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('cannabis_login.jpg'),
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: appBaseContentBackgroundColor.shade800,
                elevation: 5.0,
                child: Container(
                  margin: EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Card Header
                      SizedBox(height: 45.0),
                      SizedBox(
                        height: 100.0,
                        child: Image.asset(
                          "budwizard_logo_400x400.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text("Bud Wizard", style: appHeaderFontStyle),
                      SizedBox(height: 25.0),
                      // Username Text Field
                      DankTextField(
                        textController: usernameController,
                        onSubmit: (value) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        labelText: 'Username',
                        hintText: 'Enter your Username',
                        minWidth: 100,
                        maxWidth: 500,
                        isPassword: false,
                      ),
                      // Password Text Field
                      DankTextField(
                        textController: passwordController,
                        onSubmit: (value) {
                          performLogin();
                        },
                        focusNode: passwordFocusNode,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        minWidth: 100,
                        maxWidth: 500,
                        isPassword: true,
                      ),
                      // Conditional Failure Message
                      SizedBox(
                        height: 25.0,
                        child: Visibility(
                          visible: _failedLogin,
                          child: Text("Username or Password is invalid",
                              style: appErrorFontStyle),
                          replacement: SizedBox.shrink(),
                        ),
                      ),
                      // Signin Button
                      DankButton(
                        buttonText: "Sign In",
                        callback: performLogin,
                      ),
                      SizedBox(height: 25.0),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: SizedBox(
                  height: 36.0,
                  child: Visibility(
                    visible: _isLoading,
                    child: CircularProgressIndicator(
                      backgroundColor: appBaseColor,
                    ),
                    replacement: SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void performLogin() async {
    // Create a Login instance to pass data for the auth operation
    Login login = new Login(
        username: usernameController.text, password: passwordController.text);

    setState(() {
      _isLoading = true;
      _failedLogin = false;
    });

    // Hit the back-end API and validate the login
    login = await authLogin(login);

    setState(() {
      _isLoading = false;
    });

    // Assess the login result
    if (login != null) {
      // Note: I'm completely aware that this login will not handle the password reset yet
      // That needs an additional PBI, lets be fair.
      Navigator.pushReplacementNamed(context, uiRouteHomeScreen);
    } else {
      setState(() {
        _failedLogin = true;
      });
    }
  }
}
