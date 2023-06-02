class User {
  final String fristName;
  final String lastName;
  final String password;
  final String userName;
  // ignore: non_constant_identifier_names
  final String Role;
  final String id;
  final String farmName;

  User({
    required this.fristName,
    required this.lastName,
    required this.password,
    required this.userName,
    // ignore: non_constant_identifier_names
    required this.Role,
    required this.id,
    required this.farmName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // json = json["payload"];
    return User(
      fristName: json['fristName'],
      lastName: json['lastName'],
      password: "",
      userName: json['userName'],
      Role: json['Role'],
      id: json['_id'],
      farmName: json['farmName'],
    );
  }

  factory User.tojson(Map<String, dynamic> json) {
    return User(
      fristName: json['fristName'],
      lastName: json['lastName'],
      password: "",
      userName: json['userName'],
      Role: json['Role'],
      id: json['id'],
      farmName: json['farmName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "fristName": fristName,
      "lastName": lastName,
      "password": password,
      "userName": userName,
      "Role": Role,
      "userId": id,
      "farmName":farmName
    };
  }
}
