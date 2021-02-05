import 'dart:convert';

import 'package:bud_wizard/services/logger-service.dart';
import 'package:dio/dio.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/services/api%20services/api-services.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:flutter_guid/flutter_guid.dart';

Future<List<Grow>> getGrows(Guid userId, {String searchText = ''}) async {
  List<Grow> retval;

  try {
    if (userId != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRouteGrows);

      // Append the filter parameters
      url = url + '?UserId=' + userId.toString();
      url = url + '&SearchOnText=' + searchText;
      url = url + '&IncludeRelationalData=True';

      // Make the HTTP request
      Response response = await executeRequest(
        url,
        HttpMethod.GET,
        null,
      );

      // Process the result
      if (response != null && response.statusCode == 200) {
        retval = (response.data as List)
            .map((grows) => new Grow.fromJson(grows))
            .toList();
      } else {
        throw Exception('Failed to get Grows.');
      }
    }
  } catch (Exception) {
    log('Failed To Get Grows.');
    log(Exception);
  }

  return retval;
}

Future<bool> postGrow(Grow grow) async {
  bool retval = false;

  try {
    // Generate the request URL
    String url = generateAPIPath(apiRouteGrows);

    // Make the HTTP request
    Response response = await executeRequest(
      url,
      HttpMethod.POST,
      json.encode(grow),
    );

    // Process the result
    if (response != null && response.statusCode == 200) {
      retval = true;
    }
  } catch (Exception) {
    log('Failed Adding Grow.');
    log(Exception);
  }

  return retval;
}
