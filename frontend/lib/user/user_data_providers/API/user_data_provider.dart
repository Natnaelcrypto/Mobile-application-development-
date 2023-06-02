import 'dart:convert';
import '../../../LocalStroe/Store.dart';
import '../../../user/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  static const String baseUrl = "http://10.0.2.2:3300/api/v1/users";

  Future<User> create(User user) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "farmName": user.farmName,
          "fristName": user.fristName,
          "lastName": user.lastName,
          "password": user.password,
          "Role": user.Role,
          "userName": user.userName,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create User");
    }
  }

  Future<User> fetchOne(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching User of id failed");
    }
  }

  Future<List<User>> fetchAll() async {
    var fN = UserPreferences.farmName;
    final response = await http.get(Uri.parse("$baseUrl/$fN"));
    if (response.statusCode == 200) {
      final user = jsonDecode(response.body) as List;
      final List<User> users = user
          .map(
            (c) => User.fromJson(c),
          )
          .toList();

      return users;
    } else {
      throw Exception("Could not fetch Users");
    }
  }

  Future<User> update(String id, User user) async {
    final response = await http.patch(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "fristName": user.fristName,
          "lastName": user.lastName,
          "password": user.password,
          "Role": user.Role,
          "userName": user.userName,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the User");
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception("Field to delete the User");
    }
  }
}
