import 'dart:async';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-pro-tip.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class GrowSearchDialog extends StatefulWidget {
  @override
  _GrowSearchDialogState createState() => _GrowSearchDialogState();
}

class _GrowSearchDialogState extends State<GrowSearchDialog> {
  Future<List<Grow>> _searchResult;
  Login _user;
  bool _isLoading = false;
  String _searchText = 'What would you like to find?';

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
    return Stack(
      children: [
        Dialog(
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DankLabel(
                displayText: 'Search for Grows, Strains or Grow Techniques',
                textStyle:
                    appLabelFontStyle.copyWith(fontWeight: FontWeight.bold),
                padding: EdgeInsets.only(bottom: 8.0),
              ),
              Container(
                width: 600.0,
                decoration: BoxDecoration(
                  color: (currentTheme.currentTheme() == ThemeMode.dark)
                      ? appDarkBackgroundColor
                      : appLightTertiaryColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DankTextField(
                      hintText: 'Enter your search criteria',
                      labelText: _searchText,
                      margin: EdgeInsets.only(bottom: 15.0),
                      textPadding: EdgeInsets.only(
                        top: 30.0,
                        bottom: 30.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      onChanged: (String value) {
                        //_searchResult = searchPlants();
                        setState(() {
                          _isLoading = true;
                        });
                      },
                      onFocus: () {
                        setState(() {
                          _searchText = 'Search';
                        });
                      },
                      onLostFocus: (String value) {
                        setState(() {
                          _searchText = 'What would you like to find?';
                        });
                      },
                    ),
                    FutureBuilder<List<Grow>>(
                      future: _searchResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print('Do something fancy with the search results.');
                        }

                        return SizedBox.shrink();
                      },
                    ),
                    DankProTip(
                      proTipText: 'Search uses Plant Tags to narrow results.',
                      onLearnMore: learnMoreAboutPlantTags,
                    ),
                  ],
                ),
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

                  return Positioned.fill(
                    bottom: -400.0,
                    child: SpinKitRipple(
                      color: appBaseColor,
                      size: 150.0,
                      duration: Duration(milliseconds: 2500),
                    ),
                  );
                },
              )
            : SizedBox.shrink(),
      ],
    );
  }

  void learnMoreAboutPlantTags() {
    print('To Do: Learn about plant tags in Knowledge Base');
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
