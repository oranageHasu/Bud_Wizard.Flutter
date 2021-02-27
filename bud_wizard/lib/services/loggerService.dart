import 'package:bud_wizard/environment.dart';

void log(String message) async {
  try {
    if (!isProduction() && message.isNotEmpty) {
      // Note: this could be redirected to a cloud logger or api
      print(message);
    }
  } catch (exception) {
    print('Logger failed to log.  Embarrassing.');
  }
}
