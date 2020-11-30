// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:core';
import 'dart:convert';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/models/login.dart';
import 'package:bud_wizard/models/plant.dart';

Map<String, String> dankHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Credentials': 'true',
};

String generateAPIPath(String route) {
  return apiBaseURL + route;
}

Future<Login> authLogin(Login login) async {
  Login retval;

  try {
    // Generate the request URL
    String url = generateAPIPath(apiRouteAuthLogin);

    // Make the HTTP request
    HttpRequest request = await HttpRequest.request(url,
        responseType: '',
        withCredentials: true,
        requestHeaders: dankHeaders,
        method: 'POST',
        sendData: json.encode(login));

    // Process the result
    if (request != null && request.status == 200) {
      Map jsonResponse = json.decode(request.response);
      retval = new Login.fromJson(jsonResponse);
    }
  } catch (Exception) {
    print('Failed to authenticate login.');
  }

  return retval;
}

Future<List<Grow>> getGrows() async {
  List<Grow> retval;

  try {
    // Generate the request URL
    String url = generateAPIPath(apiRouteGrows);
    url = url +
        '?UserId=77c1e2cb-6792-4acd-ae31-3ab61a150822&IncludeRelationalData=True';

    print(url);
    // Make the HTTP request
    HttpRequest request = await HttpRequest.request(url,
        responseType: '',
        withCredentials: true,
        requestHeaders: dankHeaders,
        method: 'GET');

    // Process the result
    if (request != null && request.status == 200) {
      List jsonResponse = json.decode(request.response);
      retval = jsonResponse.map((grow) => new Grow.fromJson(grow)).toList();
    }
  } catch (Exception) {
    print('Failed to get the grows.');
  }

  return retval;
}

Future<List<Plant>> getPlants() async {
  /*
  final http.Response response = await http.get(
      'https://localhost:9000/api/v1/Plant?GrowId=08c1e2cb-6792-4acd-ae31-3ab61a150812&IncludeRelationalData=True',
      headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Access-Control-Allow-Credentials': 'true'
      });

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((plant) => new Plant.fromJson(plant)).toList();
  } else {
    throw Exception('Failed to get the plants.');
  }
  */
}
