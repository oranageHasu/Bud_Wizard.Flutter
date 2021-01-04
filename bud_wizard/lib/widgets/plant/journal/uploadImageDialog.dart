import 'dart:async';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-drop-zone.dart';
import 'package:flutter/material.dart';

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
  bool _isDisabled = true;
  bool _isLoading = false;

  _UploadImageDialogState(
    this.journalWeek,
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
            backgroundColor: appBaseBackgroundColor,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 16,
            child: DankDropZone(),
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
