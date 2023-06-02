class Auth {
  final String userName;
  final String password;
  final String token;

  Auth({
    required this.userName,
    required this.password,
    required this.token,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      userName: json['userName'],
      password: json['userID'],
      token: json['access_token'],
    );
  }
}
