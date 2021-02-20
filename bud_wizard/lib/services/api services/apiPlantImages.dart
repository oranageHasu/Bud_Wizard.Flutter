import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/models/plant%20system/plantImage.dart';
import 'package:dio/dio.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/services/api%20services/api-services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_guid/flutter_guid.dart';

Future<List<PlantImage>> getPlantImages({
  @required Guid userId,
  @required Guid plantId,
  @required int growWeek,
  String fileName,
}) async {
  List<PlantImage> retval;

  try {
    if (userId != null && plantId != null && growWeek != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRoutePlantImage);

      // Append the filter parameters
      url = url + '?UserId=' + userId.toString();
      url = url + '&ModelId=' + plantId.toString();
      url = url + '&GrowWeek=' + growWeek.toString();

      if (fileName != null) {
        url = url + '&SearchOnText=' + fileName;
      }

      // Make the HTTP request
      Response response = await executeRequest(url, HttpMethod.GET, null);

      // Process the result
      if (response != null && response.statusCode == 200) {
        retval = (response.data as List)
            .map((json) => PlantImage.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to get Plant Images.');
      }
    }
  } catch (Exception) {
    throw Exception('Failed to get Plant Images.');
  }

  return retval;
}
