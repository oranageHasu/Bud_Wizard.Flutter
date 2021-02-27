import 'dart:convert';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/journal%20system/journal.dart';
import 'package:bud_wizard/models/plant%20system/plantUpload.dart';
import 'package:bud_wizard/services/api%20services/apiServices.dart';
import 'package:dio/dio.dart';
import 'package:flutter_guid/flutter_guid.dart';

Future<Journal> getJournal(Guid plantId) async {
  Journal retval;

  try {
    if (plantId != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRouteJournal);

      // Append the filter parameters
      url = url + '?ModelId=' + plantId.toString();

      // Make the HTTP request
      Response response = await executeRequest(url, HttpMethod.GET, null);

      // Process the result
      if (response != null && response.statusCode == 200) {
        retval = Journal.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to get Plant Journal for: ' + plantId.toString());
      }
    }
  } catch (ex) {
    throw Exception(ex);
  }

  return retval;
}

Future<bool> postJournalImages(PlantUpload plantUpload) async {
  bool retval;

  try {
    if (plantUpload != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRouteJournalUpload);

      // Make the HTTP request
      Response response =
          await executeRequest(url, HttpMethod.POST, json.encode(plantUpload));

      // Process the result
      if (response != null && response.statusCode == 200) {
        retval = true;
      }
    }
  } catch (ex) {
    throw Exception(ex);
  }

  return retval;
}
