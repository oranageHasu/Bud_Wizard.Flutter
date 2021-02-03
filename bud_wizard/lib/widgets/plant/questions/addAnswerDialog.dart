import 'dart:async';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/models/question%20system/answer.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/services/api%20services/api-answer.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class AddAnswerDialog extends StatefulWidget {
  final Question question;

  AddAnswerDialog({
    @required Question question,
  }) : this.question = question;

  @override
  _AddAnswerDialogState createState() => _AddAnswerDialogState(
        this.question,
      );
}

class _AddAnswerDialogState extends State<AddAnswerDialog> {
  Question question;

  TextEditingController _answerTextController;
  Future<bool> _saveResult;
  Login _user;
  bool _answerHasFocus = false;
  bool _isDisabled = true;
  bool _isLoading = false;

  // Global Key used to uniquely identify the Form Widget.  Used for Form Validation.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _AddAnswerDialogState(
    this.question,
  );

  @override
  void initState() {
    super.initState();

    if (_user == null) {
      sessionInfo.then((data) {
        _user = data.user;
        print('From SessionInfo: ' + _user.username);
      }, onError: (e) {
        log(e);
      });
    }

    _answerTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    super.dispose();

    _answerTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Dialog(
            backgroundColor: appBackgroundColor,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 16,
            child: new GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                key: _formKey,
                child: Container(
                  width: 600.0,
                  height: 400.0,
                  color: appBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 20),
                      DankLabel(
                        displayText: question.questionTitle,
                        textAlign: TextAlign.start,
                        textStyle:
                            appLabelFontStyle.copyWith(color: appBaseColor),
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Divider(
                          color: appTertiaryColor,
                          thickness: 2.0,
                        ),
                      ),
                      SimpleTooltip(
                        animationDuration: Duration(milliseconds: 0),
                        show: _answerHasFocus,
                        tooltipDirection: TooltipDirection.right,
                        content: Container(
                          height: 85.0,
                          width: 170.0,
                          child: Column(
                            children: [
                              DankLabel(
                                displayText:
                                    'To Do: Describe how to better answer the question',
                                textStyle: appInputFontStyle,
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: appBackgroundColor,
                        borderRadius: 5.0,
                        child: DankTextField(
                          keybordType: TextInputType.multiline,
                          maxLines: 10,
                          labelText: 'Answer',
                          hintText: 'Enter your answer',
                          minWidth: 300,
                          textController: _answerTextController,
                          margin: EdgeInsets.all(15.0),
                          textPadding: EdgeInsets.all(15.0),
                          autofocus: true,
                          onChanged: formDataChanged,
                          onFocus: () {
                            setState(() {
                              //_answerHasFocus = true;
                            });
                          },
                          onLostFocus: (value) {
                            setState(() {
                              //_answerHasFocus = false;
                            });
                          },
                          maxTextCharacters: 500,
                          displayMaxCharacterValidation: true,
                        ),
                        ballonPadding: EdgeInsets.all(3.0),
                        borderWidth: 0.0,
                        arrowLength: 12,
                        arrowTipDistance: 2,
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15.0, top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DankButton(
                                  buttonText: 'Cancel',
                                  onPressed: () {
                                    dismissDialog(false);
                                  },
                                  buttonType: DankButtonType.Outline,
                                  borderRadius: 5.0,
                                  borderColor: Colors.transparent,
                                  padding: EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    top: 20.0,
                                    bottom: 20.0,
                                  ),
                                  margin: EdgeInsets.only(right: 10.0),
                                ),
                                DankButton(
                                  buttonText: 'Done',
                                  onPressed: () {
                                    dismissDialog(true);
                                  },
                                  buttonType: DankButtonType.Flat,
                                  borderRadius: 5.0,
                                  isDisabled: _isDisabled,
                                  padding: EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    top: 20.0,
                                    bottom: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          (_isLoading)
              ? FutureBuilder<bool>(
                  future: _saveResult,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_isLoading) {
                          setState(() {
                            _isLoading = false;
                          });

                          Navigator.pop(context, true);
                        }
                      });
                    } else if (snapshot.hasError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_isLoading) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      });
                    }

                    return SizedBox(
                      height: 35.0,
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              : SizedBox(height: 35.0),
        ],
      ),
    );
  }

  void formDataChanged(String value) {
    setState(() {
      _isDisabled = _answerTextController.text.isEmpty;
    });
  }

  void dismissDialog(bool opResult) async {
    Answer newAnswer;

    if (opResult) {
      setState(() {
        _isLoading = true;
      });

      newAnswer = new Answer(
        answerId: null,
        questionId: question.questionId,
        username: _user.username,
        answerText: _answerTextController.text,
      );

      _saveResult = postAnswer(newAnswer);
    } else {
      Get.back(result: false);
    }
  }
}
