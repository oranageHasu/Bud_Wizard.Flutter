import 'dart:convert';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:http/http.dart' as http;

Future<List<Grow>> getGrows() async {

  final http.Response response = await http.get(
      'https://localhost:9000/api/v1/Grow?UserId=77c1e2cb-6792-4acd-ae31-3ab61a150822&IncludeRelationalData=True',
      headers: {
        'Content-Type': 'application/json',
        "Accept":"application/json",
        "Access-Control-Allow-Origin": "*",
        'Access-Control-Allow-Credentials': 'true'
      }
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((grow) => new Grow.fromJson(grow)).toList();
  } else {
    throw Exception('Failed to get the grows.');
  }
}

Future<List<Plant>> getPlants() async {

  final http.Response response = await http.get(
      'https://localhost:9000/api/v1/Plant?GrowId=08c1e2cb-6792-4acd-ae31-3ab61a150812&IncludeRelationalData=True',
      headers: {
        'Content-Type': 'application/json',
        "Accept":"application/json",
        "Access-Control-Allow-Origin": "*",
        'Access-Control-Allow-Credentials': 'true'
      }
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((plant) => new Plant.fromJson(plant)).toList();
  } else {
    throw Exception('Failed to get the plants.');
  }
}