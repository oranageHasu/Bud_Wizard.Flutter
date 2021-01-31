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
      Response response = await executeRequest(url, HttpMethod.GET, null);

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
    throw Exception('Failed to get Grows.');
  }

  return retval;
}
