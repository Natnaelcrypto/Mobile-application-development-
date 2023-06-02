import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../../LocalStroe/Store.dart';
import '../../user/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../auth_model/auth.dart';


class AuthDataProvider {
  static const String baseUrl = "http://10.0.2.2:3300/api/v1/auth";

  Future<User> post_login(Auth auth) async {
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "password": auth.password,
          "userName": auth.userName,
        },
      ),
    );
    if (response.statusCode == 201) {
      var x = Auth.fromJson(
        jsonDecode(response.body),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserPreferences.access = x.token;
      // ignore: non_constant_identifier_names
      var user_detail = await get();

      final user = User.fromJson(
        jsonDecode(
          user_detail.toString(),
        )["payload"],
      );
      await prefs.setString("user", user.toString());

      return user;
    } else {
      throw Exception("No User Found");
    }
  }

  // ignore: non_constant_identifier_names
  Future<User> post_signup(User user) async {
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "farmName": user.farmName,
          "password": user.password,
          "userName": user.userName,
          "Role": user.Role,
          "fristName": user.fristName,
          "lastName": user.lastName,
        },
      ),
    );
    if (response.statusCode == 201) {
      var x = Auth.fromJson(
        jsonDecode(response.body),
      );

      UserPreferences.access = x.token;
      // ignore: non_constant_identifier_names
      var user_detail = await get();
      
      final user = User.fromJson(
        jsonDecode(
          user_detail.toString(),
        )["payload"],
      );

      return user;
    } else {
      throw Exception("No Auth Found");
    }
  }

  Future<String> get() async {
    var token = UserPreferences.access;
    final response = await http.get(
      Uri.parse("$baseUrl/user"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Fetching Auth of id failed");
    }
  }
}
