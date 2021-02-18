import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/models/plant%20system/plantImage.dart';
import 'package:bud_wizard/models/plant%20system/plantImageMetadata.dart';
import 'package:dio/dio.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/services/api%20services/api-services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_guid/flutter_guid.dart';

Future<List<PlantImageMetadata>> getPlantImageMetadata({
  @required Guid userId,
  @required Guid plantId,
  @required int growWeek,
}) async {
  List<PlantImageMetadata> retval;

  try {
    if (userId != null && plantId != null && growWeek != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRoutePlantImageMetadata);

      // Append the filter parameters
      url = url + '?UserId=' + userId.toString();
      url = url + '&ModelId=' + plantId.toString();
      url = url + '&GrowWeek=' + growWeek.toString();

      // Make the HTTP request
      Response response = await executeRequest(url, HttpMethod.GET, null);

      // Process the result
      if (response != null && response.statusCode == 200) {
        retval = (response.data as List)
            .map((metadata) => PlantImageMetadata.fromJson(metadata))
            .toList();
      } else {
        throw Exception('Failed to get Plant Image Metadata.');
      }
    }
  } catch (Exception) {
    throw Exception('Failed to get Plant Image Metadata.');
  }

  return retval;
}

Future<PlantImage> getPlantImage({
  @required Guid userId,
  @required Guid plantId,
  @required int growWeek,
  @required String fileName,
}) async {
  PlantImage retval;

  try {
    if (userId != null && plantId != null && growWeek != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRoutePlantImage);

      // Append the filter parameters
      url = url + '?UserId=' + userId.toString();
      url = url + '&ModelId=' + plantId.toString();
      url = url + '&GrowWeek=' + growWeek.toString();
      url = url + '&SearchOnText=' + fileName;

      // Make the HTTP request
      Response response = await executeRequest(url, HttpMethod.GET, null);

      // Process the result
      if (response != null && response.statusCode == 200) {
        retval = PlantImage.fromJson(response.data);
      } else {
        throw Exception('Failed to get Plant Image.');
      }
    }
  } catch (Exception) {
    throw Exception('Failed to get Plant Image.');
  }

  return retval;
}
