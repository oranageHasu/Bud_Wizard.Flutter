import 'dart:convert';
import 'package:bud_wizard/models/user%20system/loginPreferences.dart';
import 'package:bud_wizard/services/loggerService.dart';
import 'package:dio/dio.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/services/api%20services/apiServices.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_guid/flutter_guid.dart';

Future<LoginPreferences> getLoginPreferences({
  @required Guid userId,
}) async {
  LoginPreferences retval;

  try {
    if (userId != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRouteLoginPreferences);

      // Append the filter parameters
      url = url + '?UserId=' + userId.toString();

      // Make the HTTP request
      Response response = await executeRequest(
        url,
        HttpMethod.GET,
        null,
      );

      // Process the result
      if (response != null && response.statusCode == 200) {
        retval = LoginPreferences.fromJson(response.data);
      } else {
        throw Exception('Failed to get User Preferences.');
      }
    }
  } catch (Exception) {
    log(Exception);
  }

  return retval;
}

Future<bool> putLocationPreferences(LoginPreferences locPrefs) async {
  bool retval = false;

  try {
    // Generate the request URL
    String url = generateAPIPath(apiRouteLoginPreferences);

    // Make the HTTP request
    Response response = await executeRequest(
      url,
      HttpMethod.PUT,
      json.encode(locPrefs),
    );

    // Process the result
    if (response != null && response.statusCode == 200) {
      retval = true;
    }
  } catch (Exception) {
    log('Failed saving User Preferences.');
    log(Exception);
  }

  return retval;
}
