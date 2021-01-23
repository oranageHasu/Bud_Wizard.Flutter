import 'dart:async';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/services/api%20services/api-login.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode _passwordFocusNode = new FocusNode();
  bool _isLoading = false;
  bool _failedLogin = false;
  Future<Login> _loginResult;

  // Used for doing the fancy app name typing illusion
  final String _appName = 'Bud Wizard';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();

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
          child: Container(
            constraints: BoxConstraints(maxWidth: 500.0),
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
                      left: 35.0,
                      right: 35.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        SizedBox(
                          height: 100.0,
                          child: Image.asset(
                            "budwizard_logo_400x400.png",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: 280.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0; i < _appName.length; i++)
                                FadeIn(
                                  getFadeDelay(i),
                                  DankLabel(
                                    displayText: _appName[i],
                                    textStyle: appHeaderFontStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                  true,
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        DankTextField(
                          borderColorUnselected: Colors.white.withOpacity(0.1),
                          textController: _usernameController,
                          autofocus: true,
                          onSubmit: (value) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
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
                          borderColorUnselected: Colors.white.withOpacity(0.1),
                          textController: _passwordController,
                          onSubmit: (value) {
                            performLogin();
                          },
                          focusNode: _passwordFocusNode,
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
                          onPressed: performLogin,
                          margin: EdgeInsets.only(top: 10.0),
                          padding: EdgeInsets.all(15.0),
                          borderRadius: 10.0,
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
                (_isLoading)
                    ? FutureBuilder<Login>(
                        future: _loginResult,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              // First, establish a Session (async)
                              initSession();

                              Navigator.pushReplacementNamed(
                                context,
                                uiRouteHomeScreen,
                              );
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
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 35.0,
                                maxHeight: 35.0,
                              ),
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
      ),
    );
  }

  int getFadeDelay(int index) {
    int retval = 0;

    if (index <= 3) {
      retval = index * 1000;
    } else {
      retval = index * 550;
    }

    return retval;
  }

  void performLogin() async {
    // Create a Login instance to pass data for the auth operation
    Login login = new Login(
      username: _usernameController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = true;
    });

    // Hit the back-end API and validate the login
    _loginResult = authLogin(login);
  }
}
