import 'dart:async';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/models/plantUpload.dart';
import 'package:bud_wizard/services/api%20services/api-journal.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrowSearchDialog extends StatefulWidget {
  @override
  _GrowSearchDialogState createState() => _GrowSearchDialogState();
}

class _GrowSearchDialogState extends State<GrowSearchDialog> {
  Future<List<Grow>> _searchResult;
  Login _user;
  bool _isLoading = false;

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
                Container(
                  height: 300.0,
                  width: 600.0,
                  color: appThirdColor,
                ),
              ],
            ),
          ),
          (_isLoading)
              ? FutureBuilder<List<Grow>>(
                  future: _searchResult,
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

  void dismissDialog(bool opResult) async {
    if (opResult) {
      setState(() {
        _isLoading = true;
      });
    } else {
      Get.back(result: false);
    }
  }
}
