import 'package:flutter/foundation.dart';
import 'package:bud_wizard/classes/enumerations.dart';

class GrowPrivacy {
  GrowPrivacySetting privacySetting;
  bool sharePhotos = false;
  bool shareJournal = false;
  bool allowComments = false;
  bool allowML = true;
  bool allowNotifications = true;

  GrowPrivacy({
    @required GrowPrivacySetting privacySetting,
  }) : this.privacySetting = privacySetting;

  factory GrowPrivacy.fromJson(Map<String, dynamic> json) {
    for (GrowPrivacySetting index in GrowPrivacySetting.values) {
      print(index.index);
    }
    print(json['privacySetting']);
    GrowPrivacy retval = GrowPrivacy(
      privacySetting: GrowPrivacySetting.DoNotShare, //GrowPrivacySetting.values
      //.firstWhere((e) => e.index == json['privacySetting'] as int),
    );
    print('here2');
    retval.sharePhotos = json['sharePhotos'];
    retval.shareJournal = json['shareJournal'];
    retval.allowComments = json['allowComments'];
    retval.allowML = json['allowML'];
    retval.allowNotifications = json['allowNotifications'];

    return retval;
  }

  Map<String, dynamic> toJson() {
    return {
      'privacySetting': privacySetting.index.toString(),
      'sharePhotos': sharePhotos,
      'shareJournal': shareJournal,
      'allowComments': allowComments,
      'allowML': allowML,
      'allowNotifications': allowNotifications,
    };
  }
}
