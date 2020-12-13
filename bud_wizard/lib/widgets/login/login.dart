import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
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
  Future<Login> loginResult;

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
                color: appBaseContentBackgroundColor.withOpacity(0.9),
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 45.0),
                      SizedBox(
                        height: 100.0,
                        child: Image.asset(
                          "budwizard_logo_400x400.png",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      DankLabel(
                        width: 350.0,
                        displayText: "Bud Wizard",
                        textStyle: appHeaderFontStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25.0),
                      DankTextField(
                        textController: usernameController,
                        autofocus: true,
                        onSubmit: (value) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        labelText: 'Username',
                        hintText: 'Enter your Username',
                        minWidth: 100,
                        maxWidth: 400,
                        prefixIcon: Icon(
                          Icons.person,
                          color: appBaseWhiteTextColor,
                        ),
                        margin: EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                      ),
                      DankTextField(
                        textController: passwordController,
                        onSubmit: (value) {
                          performLogin();
                        },
                        focusNode: passwordFocusNode,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        minWidth: 100,
                        maxWidth: 400,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: appBaseWhiteTextColor,
                        ),
                        isPassword: true,
                        margin: EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                        child: Visibility(
                          visible: _failedLogin,
                          child: Text("Username or Password is invalid",
                              style: appErrorFontStyle),
                          replacement: SizedBox.shrink(),
                        ),
                      ),
                      DankButton(
                        buttonText: "Sign In",
                        callback: performLogin,
                        margin: EdgeInsets.only(top: 10.0),
                      ),
                      SizedBox(height: 25.0),
                    ],
                  ),
                ),
              ),
              (_isLoading)
                  ? FutureBuilder<Login>(
                      future: loginResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacementNamed(context, '/Home');
                          });
                        } else if (snapshot.hasError) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _isLoading = false;
                              _failedLogin = true;
                            });
                          });
                        }

                        return Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: SizedBox(
                            height: 35.0,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    )
                  : SizedBox(height: 60.0),
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
    });

    // Hit the back-end API and validate the login
    loginResult = authLogin(login);
  }
}
