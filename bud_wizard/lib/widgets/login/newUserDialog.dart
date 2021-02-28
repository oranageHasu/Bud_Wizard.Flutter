import 'dart:async';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/user%20system/login.dart';
import 'package:bud_wizard/services/api%20services/apiLogin.dart';
import 'package:bud_wizard/services/loggerService.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewUserDialog extends StatefulWidget {
  @override
  _NewUserDialogState createState() => _NewUserDialogState();
}

class _NewUserDialogState extends State<NewUserDialog> {
  TextEditingController _usernameTextController;
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;
  TextEditingController _passwordValidationTextController;
  FocusNode usernameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode passwordValidationNode = FocusNode();

  Login _user = Login();
  Future<bool> _addResult;
  Future<bool> usernameCheckResult;

  bool _isLoading = false;
  bool _isDisabled = true;
  bool _submitError = false;
  bool _isUsernameAvailable = true;

  // Timer used to do username validation
  Timer _timer;

  // Global Key used to uniquely identify the Form Widget.  Used for Form Validation.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _usernameTextController = TextEditingController(text: '');
    _emailTextController = TextEditingController(text: '');
    _passwordTextController = TextEditingController(text: '');
    _passwordValidationTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    super.dispose();

    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passwordValidationTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Dialog(
            backgroundColor: appDarkBackgroundColor,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 16,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: _buildForm(),
            ),
          ),
          _buildLoader(),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return (_isLoading)
        ? FutureBuilder<bool>(
            future: _addResult,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_isLoading) {
                    setState(() {
                      _isLoading = false;
                    });

                    if (snapshot.data) {
                      Navigator.pop(context, true);
                    } else {
                      setState(() {
                        _submitError = true;
                      });
                    }
                  }
                });
              } else if (snapshot.hasError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_isLoading) {
                    setState(() {
                      _isLoading = false;
                      _submitError = true;
                    });
                  }
                });
              }

              return SizedBox(
                height: 35.0,
                child: Center(
                  child: FadeIn(
                    duration: 800,
                    isVisible: true,
                    child: SpinKitWave(
                      color: appBaseColor,
                      size: 30.0,
                    ),
                  ),
                ),
              );
            },
          )
        : SizedBox(height: 35.0);
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        width: 550.0,
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Center(
              child: DankLabel(
                displayText: 'Bud Wizard Signup',
                textStyle: appHeaderFontStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(bottom: 25.0),
              child: Divider(
                color: appDarkUnselectedColor,
                thickness: 2.0,
              ),
            ),
            DankTextField(
              labelText: 'Username',
              hintText: 'Enter your username',
              maxWidth: 130,
              prefixIcon: Icon(
                Icons.security,
                color: appDarkUnselectedColor,
              ),
              autofocus: true,
              textController: _usernameTextController,
              textColor: appBaseWhiteTextColor,
              hintTextColor: appDarkUnselectedColor,
              onValidate: _validateUsername,
              onChanged: _usernameChanged,
              maxTextCharacters: 20,
              displayMaxCharacterValidation: true,
              onSubmit: (String value) {
                FocusScope.of(context).requestFocus(emailNode);
              },
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DankButton(
                    buttonText: 'Sign Up',
                    onPressed: () {
                      _dismissDialog(context, true);
                    },
                    margin: EdgeInsets.only(right: 10.0),
                    isDisabled: _isDisabled,
                    buttonType: DankButtonType.Flat,
                    textColor: appBaseWhiteTextColor,
                  ),
                  DankButton(
                    buttonText: 'Cancel',
                    onPressed: () {
                      _dismissDialog(context, false);
                    },
                    margin: EdgeInsets.only(left: 10.0),
                    textColor: appBaseWhiteTextColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validateUsername(String value) {
    String retval;

    if (value.isEmpty) {
      _user.username = value;
      retval = 'Username is a required field';
    } else if (value != _user.username) {
      _user.username = value;

      if (_timer != null && _timer.isActive) {
        _timer.cancel();
      }

      // Give the user less than a 1/2 second to continue typing; If they don't check if this username is unique
      // Pro Tip: You can beat the timer with a well timed key press :)
      _timer = Timer(Duration(milliseconds: 400), _checkUsernameIsUnqiue);
    } else if (!_isUsernameAvailable) {
      retval = 'Username is currently in use';
    }

    return retval;
  }

  void _checkUsernameIsUnqiue() {
    usernameCheckResult = checkUsername(_user.username).whenComplete(() => {
          usernameCheckResult.then((data) {
            _isUsernameAvailable = data;

            _formDataChanged(null);

            _timer.cancel();
          }, onError: (e) {
            log(
              e,
            );
          })
        });
  }

  void _usernameChanged(String value) {
    setState(() {
      _isDisabled = true;
      _formKey.currentState.validate();
    });
  }

  void _formDataChanged(String value) {
    setState(() {
      _isDisabled = !_formKey.currentState.validate();
    });
  }

  void _dismissDialog(BuildContext context, bool opResult) {
    if (opResult) {
      setState(() {
        _isLoading = true;
      });

      //_addResult = addUser(_user);
    } else {
      Navigator.pop(context, false);
    }
  }
}
