import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../LocalStroe/Store.dart';
import '../../model/herd_model.dart';

class HerdDataProvider {
  static const String baseUrl = "http://10.0.2.2:3300/api/v1/herds";

  Future<Herd> create(Herd herd) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "farmname": herd.farmname,
          "age": herd.age,
          "bread": herd.bread,
          "gender": herd.gender,
          "health_history": herd.health_history,
          "herdID": herd.herdID,
          "medication": herd.medication,
          "pregnancy": herd.pregnancy,
          "vaccination": herd.vaccination,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return Herd.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Herd");
    }
  }

  Future<Herd> fetchOne(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/single/$id"));
    print(response.body);
    if (response.statusCode == 200) {
      return Herd.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Herd of id failed");
    }
  }

  Future<List<Herd>> fetchAll() async {
    var fN = UserPreferences.farmName;
    final response = await http.get(Uri.parse("$baseUrl/$fN"));
    if (response.statusCode == 200) {
      final herd = jsonDecode(response.body) as List;
      return herd.map((c) => Herd.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Herds");
    }
  }

  Future<Herd> update(String id, Herd herd) async {
    final response = await http.patch(
      Uri.parse("$baseUrl/${herd.id}"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "farmname": herd.farmname,
          "age": herd.age,
          "bread": herd.bread,
          "gender": herd.gender,
          "health_history": herd.health_history,
          "herdID": herd.herdID,
          "medication": herd.medication,
          "pregnancy": herd.pregnancy,
          "vaccination": herd.vaccination,
        },
      ),
    );
    print(response.body);
    print("after response");
    if (response.statusCode == 200) {
      return Herd.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Herd");
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the course");
    }
  }
}
