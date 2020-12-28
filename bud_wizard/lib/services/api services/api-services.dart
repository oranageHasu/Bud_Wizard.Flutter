import 'dart:core';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:dio/adapter_browser.dart';
import 'package:bud_wizard/environment.dart';
import 'package:dio/dio.dart' as dioHttp;
import 'package:bud_wizard/widgets/login/login.dart';
import 'package:get/get.dart';

final dioHttp.Dio _dio = dioHttp.Dio();

Map<String, String> furiousHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Credentials': 'true',
};

String generateAPIPath(String route) {
  return BASE_URL + route;
}

Future<dioHttp.Response> executeRequest(
  String url,
  HttpMethod method,
  String body,
) async {
  dioHttp.Response response;

  try {
    // Set the required headers
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["accept"] = 'application/json';
    _dio.options.headers["Access-Control-Allow-Origin"] = '*';
    _dio.options.headers["Access-Control-Allow-Credentials"] = 'true';

    // Required to set browser cookies
    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    _dio.httpClientAdapter = adapter;

    // Make the HTTP request
    switch (method) {
      case HttpMethod.GET:
        response = await _dio.get(url);
        break;

      case HttpMethod.POST:
        response = await _dio.post(url, data: body);
        break;

      case HttpMethod.PUT:
        response = await _dio.put(url, data: body);
        break;

      case HttpMethod.DELETE:
        response = await _dio.delete(url, data: body);
        break;
    }
  } on dioHttp.DioError catch (e) {
    if (e.response.statusCode == 404) {
      print(
          'ERROR --- api-service.executeRequest() - http 404 (unknown) returned from http request.');
    } else if (e.response.statusCode == 401) {
      print('Unauthorized!');
      Get.off(LoginPage());
    } else {
      print('ERROR --- api-service.executeRequest() - http error: ' +
          e.response.statusCode.toString());
    }
  }

  return response;
}
