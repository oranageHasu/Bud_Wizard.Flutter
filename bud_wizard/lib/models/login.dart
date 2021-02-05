import 'package:flutter_guid/flutter_guid.dart';

class Login {
  final Guid userId = new Guid('77c1e2cb-6792-4acd-ae31-3ab61a150822');
  String username;
  String email;
  String password;
  String newPassword;
  String accessToken;
  bool tooManyFailedAttempts = false;

  Login({
    this.username,
    this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    Login login = new Login(
      username: json['username'],
      password: json['password'],
    );

    login.email = json['email'];
    login.accessToken = json['accessToken'];
    login.tooManyFailedAttempts = json['tooManyFailedAttempts'] == 1;

    if (login.username == null || login.username.isEmpty) {
      login.username = 'TestUser';
    }

    return login;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
