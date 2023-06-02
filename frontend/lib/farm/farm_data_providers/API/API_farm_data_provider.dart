import 'dart:convert';


import 'package:http/http.dart' as http;

import '../../../LocalStroe/Store.dart';
import '../../farm_model/farm_model.dart';

class FarmDataProvider {
  static const String baseUrl = "http://10.0.2.2:3300/api/v1/farms";


  Future<Farm> create(Farm farm) async {
    print(farm.farmName);
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "farmName": farm.farmName,
          "userID": farm.userID,
          "brand": farm.brand,
          "dosage": farm.dosage,
          "expirationDate": farm.expirationDate,
          "instructions": farm.instructions,
          "isfeed": farm.isfeed,
          "ismedication": farm.ismedication,
          "itemName": farm.itemName,
          "quantity": farm.quantity,
          "type": farm.type,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return Farm.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Farm");
    }
  }

  Future<Farm> fetchOne(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Farm.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Farm of id failed");
    }
  }

  Future<List<Farm>> fetchAll() async {
    var fN = UserPreferences.farmName;
    final response = await http.get(Uri.parse("$baseUrl/$fN"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      final List farm = jsonDecode(response.body.toString()) as List;
      final List<Farm> farmlist = farm
          .map(
            (c) => Farm.fromJson(c),
          )
          .toList();
      return farmlist;
    } else {
      throw Exception("Could not fetch farms");
    }
  }

  Future<Farm> update(String id, Farm farm) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "farmName": farm.farmName,
          "userID": farm.userID,
          "brand": farm.brand,
          "dosage": farm.dosage,
          "expirationDate": farm.expirationDate,
          "id_": farm.id_,
          "instructions": farm.instructions,
          "isfeed": farm.isfeed,
          "ismedication": farm.ismedication,
          "itemName": farm.itemName,
          "quantity": farm.quantity,
          "type": farm.type,
        },
      ),
    );
    if (response.statusCode == 200) {
      return Farm.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the farm");
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception("Field to delete the course");
    }
  }
}
