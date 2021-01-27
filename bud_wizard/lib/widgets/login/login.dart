import 'dart:async';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/services/api%20services/api-login.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  bool _loggingIn = false;
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
    return alternativeLogin();
  }

  Widget alternativeLogin() {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('cannabis_login.jpg'),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                stops: [
                  0.0,
                  0.7,
                ],
              ),
            ),
          ),
          FadeIn(
            2500,
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 100.0,
                    margin: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Image.asset(
                      "budwizard_logo_400x400.png",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  DankLabel(
                    displayText: _appName,
                    textStyle: appHeaderFontStyle,
                    letterSpacing: 4.0,
                  ),
                  (_loggingIn) ? loginPanel() : buttonPanel(),
                ],
              ),
            ),
            true,
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

                    return Center(
                      child: SpinKitRipple(
                        color: appBaseColor,
                        size: 200.0,
                        duration: Duration(milliseconds: 2500),
                      ),
                    );
                  },
                )
              : SizedBox(height: 60.0),
        ],
      ),
    );
  }

  Widget buttonPanel() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 60.0,
            bottom: 10.0,
          ),
          child: DankLabel(
            displayText: 'Discover Unbelievable Yields...',
            textStyle: appLabelHeaderFontStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 70.0),
          constraints: BoxConstraints(
            minWidth: 450.0,
            maxWidth: 650.0,
          ),
          child: DankLabel(
            displayText:
                'Allow shared community and the Bud Wizard magic to increase the quality and yield of your crops, while providing you a secure/anonymous environment',
            textStyle: appLabelFontStyle.copyWith(fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 300.0,
          margin: EdgeInsets.only(bottom: 10.0),
          child: DankButton(
            buttonType: DankButtonType.Flat,
            buttonText: 'Sign Up',
            onPressed: signUp,
            textColor: appBaseColor,
            backgroundColor: appBaseWhiteTextColor,
            hoverColor: Colors.black.withOpacity(0.05),
            padding: EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),
            borderRadius: 12.0,
          ),
        ),
        Container(
          width: 300.0,
          margin: EdgeInsets.only(bottom: 10.0),
          child: DankButton(
            buttonType: DankButtonType.Flat,
            buttonText: 'Continue with Google',
            onPressed: googleLogin,
            textColor: appBaseWhiteTextColor,
            backgroundColor: Colors.blueAccent,
            hoverColor: Colors.black.withOpacity(0.05),
            padding: EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),
            borderRadius: 12.0,
          ),
        ),
        Container(
          width: 300.0,
          margin: EdgeInsets.only(bottom: 30.0),
          child: DankButton(
            buttonType: DankButtonType.Flat,
            buttonText: 'Log In',
            onPressed: budWizardLogin,
            textColor: appBaseColor,
            backgroundColor: Colors.black,
            hoverColor: Colors.white.withOpacity(0.05),
            padding: EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),
            borderRadius: 12.0,
          ),
        )
      ],
    );
  }

  Widget loginPanel() {
    return Container(
      constraints: BoxConstraints(maxWidth: 500.0),
      margin: EdgeInsets.only(
        bottom: 50.0,
        top: 35.0,
        left: 35.0,
        right: 35.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          DankTextField(
            borderColorUnselected: Colors.white.withOpacity(0.1),
            textController: _usernameController,
            autofocus: true,
            onSubmit: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
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
        ],
      ),
    );
  }

  signUp() {
    print('To Do: Sign Up');
  }

  googleLogin() {
    print('To Do: Google Login');
  }

  budWizardLogin() {
    setState(() {
      _loggingIn = true;
    });
  }

  int getFadeDelay(int index) {
    return (index + 1) * 350;
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
