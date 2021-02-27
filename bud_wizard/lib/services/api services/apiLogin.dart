import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/services/api%20services/apiServices.dart';
import 'package:bud_wizard/models/user%20system/login.dart';

Future<Login> authLogin(Login login) async {
  Login retval;

  try {
    // Generate the request URL
    String url = generateAPIPath(apiRouteAuthLogin);

    // Make the HTTP request
    Response response =
        await executeRequest(url, HttpMethod.POST, json.encode(login));

    // Process the result
    if (response != null && response.statusCode == 200) {
      retval = new Login.fromJson(response.data);
    } else {
      throw Exception('Failed to authenticate login.');
    }
  } catch (Exception) {
    throw Exception('Failed to authenticate login.');
  }

  return retval;
}

Future<bool> logout() async {
  bool retval = false;

  try {
    // Generate the request URL
    String url = generateAPIPath(apiRouteLogout);

    // Make the HTTP request
    Response response = await executeRequest(url, HttpMethod.POST, null);

    // Process the result
    if (response != null && response.statusCode == 200) {
      retval = true;
    } else {
      throw Exception('Failed to logout user.');
    }
  } catch (Exception) {
    throw Exception('Failed to logout user.');
  }

  return retval;
}
