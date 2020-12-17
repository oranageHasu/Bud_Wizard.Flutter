import 'package:bud_wizard/models/login.dart';

class SessionInfo {
  Login user;

  SessionInfo({
    this.user,
  });

  factory SessionInfo.fromJson(Map<String, dynamic> json) {
    SessionInfo sessionInfo = new SessionInfo(
      user: new Login.fromJson(json['user']),
    );

    return sessionInfo;
  }
}
