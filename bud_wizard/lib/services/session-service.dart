import 'package:dio/dio.dart' as dio;
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/sessionInfo.dart';
import 'package:bud_wizard/services/api%20services/api-services.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/widgets/login/login.dart';
import 'package:get/get.dart';

// Singleton representing the current Session
// Note: This is retrieved asynchronously, thus any widget using this must use a FutureBuilder
Future<SessionInfo> sessionInfo;

Future<void> initSession() async {
  sessionInfo = getSessionData();
}

Future<SessionInfo> getSessionData() async {
  SessionInfo retval;

  try {
    log('Loading Session Info.');

    // Generate the request URL
    String url = generateAPIPath(apiRouteSession);

    // Make the HTTP request
    dio.Response response = await executeRequest(url, HttpMethod.GET, null);

    // Process the result
    if (response != null && response.statusCode == 200) {
      retval = new SessionInfo.fromJson(response.data);
    } else if (response != null && response.statusCode == 401) {
      log('You tried to manually access a url.');
      Get.off(LoginPage());
    } else {
      log('Status Code: ' + response.statusCode.toString());
      throw Exception('Failed to get Session info.');
    }

    log('Completed loading Session Info for: ' + retval.user.username);
  } catch (exception) {
    log('Unable to get Session Info.');
  }

  return retval;
}

bool userHasAccess(UserRole minAccesslevel, UserRole currentAccessLevel) {
  return currentAccessLevel.index <= minAccesslevel.index;
}
