import 'dart:async';
import 'dart:html';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-checkbox.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-drop-zone.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadImageDialog extends StatefulWidget {
  final JournalWeek journalWeek;

  UploadImageDialog({
    @required JournalWeek journalWeek,
  }) : this.journalWeek = journalWeek;

  @override
  _UploadImageDialogState createState() => _UploadImageDialogState(
        this.journalWeek,
      );
}

class _UploadImageDialogState extends State<UploadImageDialog> {
  JournalWeek journalWeek;

  Future<bool> _saveResult;
  Login _user;
  List<File> _files = <File>[];
  bool _isLoading = false;
  bool _performML = true;

  _UploadImageDialogState(
    this.journalWeek,
  );

  @override
  void initState() {
    super.initState();

    if (_user == null) {
      sessionInfo.then((data) {
        _user = data.user;
      }, onError: (e) {
        log(e);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Dialog(
            backgroundColor: appThirdColor,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 16,
            child: Column(
              children: [
                DankDropZone(
                  onAddFiles: addFiles,
                ),
                Container(
                  height: 80.0,
                  width: 600.0,
                  color: appBaseBackgroundColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DankCheckbox(
                        onChanged: onChanged,
                        value: _performML,
                        margin: EdgeInsets.only(
                          left: 25.0,
                          right: 5.0,
                        ),
                        tooltipText:
                            'Analyze this plant image, using advanced Machine Learning and Data Science algorithms',
                      ),
                      DankLabel(
                        displayText: (_files.length <= 1)
                            ? 'Analyze Image'
                            : 'Analyze Images',
                        textStyle: appInputHintFontStyle,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DankButton(
                                buttonText: 'Cancel',
                                onPressed: onCancelPressed,
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
                                buttonText: 'Upload',
                                onPressed: onUploadPressed,
                                buttonType: DankButtonType.Flat,
                                borderRadius: 5.0,
                                isDisabled: _files.length == 0,
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
                    ],
                  ),
                ),
              ],
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

  void onUploadPressed() {
    print('To Do: Upload');
  }

  void onCancelPressed() {
    Get.back(result: false);
  }

  void onChanged(bool val) {
    setState(() {
      _performML = val;
    });
  }

  void addFiles(List<File> newFiles) {
    this.setState(() {
      _files = _files..addAll(newFiles);
    });
  }

  void dismissDialog(BuildContext context, bool opResult) async {
    if (opResult) {
      setState(() {
        _isLoading = true;
      });
    } else {
      Navigator.pop(context, false);
    }
  }
}
