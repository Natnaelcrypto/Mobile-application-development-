import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../LocalStroe/Store.dart';
import '../../../task/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskDataProvider {
  static const String baseUrl = "http://10.0.2.2:3300/api/v1/task";

  Future<Task> create(Task task) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "detail": task.detail,
          "status": task.status,
          "title": task.title,
          "farmname": task.farmname,
          "assgined_to": task.assgined_to
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return Task.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Task");
    }
  }

  Future<Task> fetchOne(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Task of id failed");
    }
  }

  Future<List<Task>> fetchAll() async {
    var fN = UserPreferences.farmName;
    final response = await get(Uri.parse("$baseUrl/$fN"));
    print(response.body);

    if (response.statusCode == 200) {
      final task = jsonDecode(response.body) as List;
      return task.map((c) => Task.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Tasks");
    }
  }

  Future<Task> update(String id, Task task) async {
    print(id);
    final response = await http.patch(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "detail": task.detail,
          "status": task.status,
          "title": task.title,
          "farmname": task.farmname,
          "assgined_to": task.assgined_to
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Task.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Could not update the Task");
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the course");
    }
  }
}
