import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/grow%20system/growLight.dart';
import 'package:bud_wizard/models/grow%20system/growPrivacy.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/grow/add/originStory.dart';
import 'package:bud_wizard/widgets/grow/add/privacy.dart';
import 'package:bud_wizard/widgets/grow/add/techIntegrations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-stepper.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddGrow extends StatefulWidget {
  static AddGrowState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AddGrowWidget>().growData;
  }

  @override
  State<StatefulWidget> createState() => AddGrowState();
}

class AddGrowState extends State<AddGrow> {
  Grow _newGrow;

  @override
  void initState() {
    sessionInfo.then((data) {
      setState(() {
        _newGrow = Grow(userId: data.user.userId);
      });
    }, onError: (e) {
      log(e);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(AddGrow oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AddGrowWidget(
      growData: this,
      child: FadeIn(
        duration: 1000,
        isVisible: true,
        child: Container(
          margin: EdgeInsets.only(top: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              DankStepper(
                selectedColor: appBaseColor,
                unselectedColor: appBaseWhiteTextColor.withOpacity(0.7),
                onFinished: persistGrow,
                steps: [
                  DankStepItem(
                    title: 'Origin Story',
                    subtitle: 'Where it all begins...',
                    icon: CommunityMaterialIcons.account_edit,
                    content: OriginStory(
                      grow: _newGrow,
                    ),
                  ),
                  DankStepItem(
                    title: 'Tech Integrations',
                    subtitle: 'For the fancy grower',
                    icon: CommunityMaterialIcons.cogs,
                    content: TechIntegrations(
                      grow: _newGrow,
                    ),
                  ),
                  DankStepItem(
                    title: 'Privacy',
                    subtitle: 'Growing bud can be risky...',
                    icon: CommunityMaterialIcons.shield_lock,
                    content: Privacy(
                      grow: _newGrow,
                    ),
                  ),
                  DankStepItem(
                    title: 'Review',
                    subtitle: 'Dot the i\'s and cross the t\'s',
                    icon: CommunityMaterialIcons.eye_check,
                    content: DankLabel(
                      displayText: 'To Do: Review',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateGrowName(String name) {
    _newGrow.name = name;
  }

  void updateGrowDate(DateTime date) {
    _newGrow.startDate = date;
  }

  void setGrowSetting(GrowSetting setting) {
    setState(() {
      _newGrow.setting = setting;
    });
  }

  void setGrowLighting(List<GrowLight> lights) {
    setState(() {
      _newGrow.growLights = lights;
    });
  }

  void updatePrivacy(GrowPrivacy privacySettings) {
    _newGrow.privacySettings = privacySettings;
  }

  void persistGrow() {
    print('Origin Story:');
    print('Name: ' + _newGrow.name);
    print('Location: ' + formatEnum(_newGrow.setting.toString()));
    print('Start Date: ' + formatDateDisplay(_newGrow.startDate));

    print('\n\nPrivacy:');
    print('Blanket Setting: ' +
        formatEnum(_newGrow.privacySettings.privacySetting.toString()));
    print('Sharing Images: ' + _newGrow.privacySettings.sharePhotos.toString());
    print(
        'Sharing Journal: ' + _newGrow.privacySettings.shareJournal.toString());
    print('Allowing Comments: ' +
        _newGrow.privacySettings.allowComments.toString());
    print('Allows ML: ' + _newGrow.privacySettings.allowML.toString());
    print('Allows Notifications: ' +
        _newGrow.privacySettings.allowNotifications.toString());
  }
}

class AddGrowWidget extends InheritedWidget {
  final AddGrowState growData;

  AddGrowWidget({
    Key key,
    @required Widget child,
    @required this.growData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AddGrowWidget oldWidget) {
    return true;
  }
}
