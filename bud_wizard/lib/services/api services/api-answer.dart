import 'dart:convert';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/question%20system/answer.dart';
import 'package:bud_wizard/services/api%20services/api-services.dart';
import 'package:dio/dio.dart';

Future<bool> postAnswer(Answer answer) async {
  bool retval;

  try {
    if (answer != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRouteAnswer);

      // Make the HTTP request
      Response response =
          await executeRequest(url, HttpMethod.POST, json.encode(answer));

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
