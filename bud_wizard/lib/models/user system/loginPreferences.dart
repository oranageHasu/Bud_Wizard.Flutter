import 'package:flutter/foundation.dart';
import 'package:flutter_guid/flutter_guid.dart';

class LoginPreferences {
  final Guid loginPreferencesId;
  final Guid userId = Guid('77c1e2cb-6792-4acd-ae31-3ab61a150822');
  bool prefersDarkMode;

  LoginPreferences({
    @required Guid loginPreferencesId,
    bool prefersDarkMode = true,
  })  : this.loginPreferencesId = loginPreferencesId,
        this.prefersDarkMode = prefersDarkMode;

  factory LoginPreferences.fromJson(Map<String, dynamic> json) {
    LoginPreferences loginPref = LoginPreferences(
      loginPreferencesId: Guid(json['loginPreferencesId']),
    );

    loginPref.prefersDarkMode = json['prefersDarkMode'];

    return loginPref;
  }

  Map<String, dynamic> toJson() {
    return {
      if (loginPreferencesId != null)
        'loginPreferencesId': loginPreferencesId.toString()
      else
        'loginPreferencesId': null,
      if (userId != null) 'userId': userId.toString() else 'userId': null,
      'prefersDarkMode': prefersDarkMode,
    };
  }
}
