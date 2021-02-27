import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/services/api%20services/apiServices.dart';
import 'package:dio/dio.dart';
import 'package:flutter_guid/flutter_guid.dart';

Future<List<Question>> getQuestions(Guid plantId) async {
  List<Question> retval;

  try {
    if (plantId != null) {
      // Generate the request URL
      String url = generateAPIPath(apiRouteQuestion);

      // Append the filter parameters
      url = url + '?ModelId=' + plantId.toString();

      // Make the HTTP request
      Response response = await executeRequest(url, HttpMethod.GET, null);

      // Process the result
      if (response != null && response.statusCode == 200) {
        retval = (response.data as List)
            .map((questions) => new Question.fromJson(questions))
            .toList();
      } else {
        throw Exception('Failed to get Questions for: ' + plantId.toString());
      }
    }
  } catch (ex) {
    throw Exception(ex);
  }

  return retval;
}
