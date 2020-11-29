class Login {
  String username;
  String password;
  String newPassword;
  String accessToken;
  bool tooManyFailedAttempts = false;

  Login({this.username, this.password});

  factory Login.fromJson(Map<String, dynamic> json) {
    Login login = new Login(
      username: json['username'],
      password: json['password'],
    );

    login.accessToken = json['accessToken'];
    login.tooManyFailedAttempts = json['tooManyFailedAttempts'] == 1;

    return login;
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
