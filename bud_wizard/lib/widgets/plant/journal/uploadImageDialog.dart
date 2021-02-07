import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:bud_wizard/models/user%20system/login.dart';
import 'package:bud_wizard/models/plantUpload.dart';
import 'package:bud_wizard/services/api%20services/api-journal.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-checkbox.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-drop-zone.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';

class UploadImageDialog extends StatefulWidget {
  final Guid plantId;
  final JournalWeek journalWeek;

  UploadImageDialog({
    @required Guid plantId,
    @required JournalWeek journalWeek,
  })  : this.plantId = plantId,
        this.journalWeek = journalWeek;

  @override
  _UploadImageDialogState createState() => _UploadImageDialogState(
        this.plantId,
        this.journalWeek,
      );
}

class _UploadImageDialogState extends State<UploadImageDialog> {
  Guid plantId;
  JournalWeek journalWeek;

  Future<bool> _uploadResult;
  Login _user;
  List<String> _base64Images = new List<String>();
  bool _isLoading = false;
  bool _performML = true;

  _UploadImageDialogState(
    this.plantId,
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
            backgroundColor: (currentTheme.currentTheme() == ThemeMode.dark)
                ? appDarkTertiaryColor
                : appLightTertiaryColor,
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
                  height: 70.0,
                  width: 600.0,
                  color: (currentTheme.currentTheme() == ThemeMode.dark)
                      ? appDarkBackgroundColor
                      : appLightBackgroundColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DankCheckbox(
                        onChanged: onAnalyzeDataChanged,
                        value: _performML,
                        margin: EdgeInsets.only(
                          left: 25.0,
                          right: 5.0,
                        ),
                        tooltipText:
                            'Analyze this plant image, using advanced Machine Learning and Data Science algorithms',
                      ),
                      DankLabel(
                        displayText: (_base64Images.length <= 1)
                            ? 'Analyze Image'
                            : 'Analyze Images',
                        textStyle: appInputHintFontStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
                                isDisabled: _base64Images.length == 0,
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
                  future: _uploadResult,
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
    dismissDialog(true);
  }

  void onCancelPressed() {
    Get.back(result: false);
  }

  void onAnalyzeDataChanged(bool val) {
    setState(() {
      _performML = val;
    });
  }

  void addFiles(List<File> newFiles) {
    getImages(newFiles);
  }

  void dismissDialog(bool opResult) async {
    if (opResult) {
      setState(() {
        _isLoading = true;
      });

      PlantUpload upload = new PlantUpload(
        plantId: plantId,
        userId: _user.userId,
        images: _base64Images,
        growWeek: journalWeek.weekNumber,
      );

      _uploadResult = postJournalImages(upload);
    } else {
      Get.back(result: false);
    }
  }

  void getImages(List<File> newFiles) {
    for (File file in newFiles) {
      FileReader reader = new FileReader();
      reader.readAsDataUrl(file);

      reader.onLoad.listen((data) {
        setState(() {
          _base64Images.add(reader.result);
        });
      });
      reader.onError.listen((fileEvent) {
        log("ERROR - Unable to read plant image file.");
      });
    }
  }
}
