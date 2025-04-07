import 'dart:io';
import 'package:easeops_hrms/app_export.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  Future<dynamic> makeRequest({
    required String method,
    required String url,
    Map<String, dynamic>? jsonBody,
    List<Map<String, dynamic>>? jsonBody1,
    bool isBoolReturn = false,
  }) async {
    dynamic responseJson;
    try {
      final response =
          await sendHttpRequest(method, url, jsonBody, jsonBody1).timeout(
        const Duration(seconds: 20),
        onTimeout: () => throw TimeoutException('Please Try Again..'),
      );

      Logger.log(url);
      Logger.log(response.body);
      Logger.log('$method Request: ${jsonEncode(jsonBody ?? {})}');
      responseJson = returnResponse(response, isBoolReturn: isBoolReturn);

      await addLogAndCrashAnalytics(
        requestType: method,
        url: url,
        response: response,
      );
    } on SocketException {
      throw FetchDataException('');
    }
    return responseJson;
  }

  Future<http.Response> sendHttpRequest(
    String method,
    String url,
    Map<String, dynamic>? jsonBody,
    List<Map<String, dynamic>>? jsonBody1,
  ) {
    final uri = Uri.parse('${ApiEndPoints.baseApi}$url');
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer ${GetStorageHelper.getUserData().token}',
    };
    final body = jsonBody != null
        ? jsonEncode(jsonBody)
        : jsonBody1 != null
            ? jsonEncode(jsonBody1)
            : null;
    switch (method) {
      case 'GET':
        return http.get(uri, headers: headers);
      case 'POST':
        return http.post(uri, headers: headers, body: body);
      case 'PUT':
        return http.put(uri, headers: headers, body: body);
      case 'PATCH':
        return http.patch(uri, headers: headers, body: body);
      case 'DELETE':
        return http.delete(uri, headers: headers);
      default:
        throw UnsupportedError('Unsupported HTTP method');
    }
  }

  @override
  Future<dynamic> getResponse(String url) =>
      makeRequest(method: 'GET', url: url);

  @override
  Future<dynamic> postResponse(String url, Map<String, dynamic> jsonBody) =>
      makeRequest(method: 'POST', url: url, jsonBody: jsonBody);

  @override
  Future<dynamic> putResponse(
    String url,
    Map<String, dynamic>? jsonBody, {
    List<Map<String, dynamic>>? jsonBody1,
    bool isBoolReturn = false,
  }) =>
      makeRequest(
        method: 'PUT',
        url: url,
        jsonBody: jsonBody,
        jsonBody1: jsonBody1,
        isBoolReturn: isBoolReturn,
      );

  @override
  Future<dynamic> patchResponse(
    String url,
    Map<String, dynamic> jsonBody, {
    bool isBoolReturn = false,
  }) =>
      makeRequest(
        method: 'PATCH',
        url: url,
        jsonBody: jsonBody,
        isBoolReturn: isBoolReturn,
      );

  @override
  Future<dynamic> deleteResponse(String url) =>
      makeRequest(method: 'DELETE', url: url);

  dynamic returnResponse(http.Response response, {bool isBoolReturn = false}) {
    switch (response.statusCode) {
      case 200:
        return isBoolReturn
            ? true
            : jsonDecode(utf8.decode(response.bodyBytes));
      case 202:
      case 204:
        return true;
      case 400:
        throw BadRequestException('Please Check Again..');
      case 401:
        throw UnauthorizedException(
          (jsonDecode(response.body) as Map<String, dynamic>)['detail'][0]
                  ['msg']
              .toString(),
        );
      case 403:
      case 404:
        throw UnauthorisedRequestException('Please Try Again..');
      case 422:
        throw UnProcessableEntityException(
          // ignore: avoid_dynamic_calls
          (jsonDecode(response.body) as Map<String, dynamic>)['detail'][0]
                  ['msg']
              .toString(),
        );
      case >= 500:
        throw ServerException('Server error, Please Try Again..');
      default:
        throw DefaultException(
          (jsonDecode(response.body) as Map<String, dynamic>).toString(),
        );
    }
  }

  Future<void> addLogAndCrashAnalytics({
    required http.Response response,
    required String url,
    required String requestType,
  }) async {
    Logger.log('$requestType URL: ${Uri.parse('${ApiEndPoints.baseApi}$url')}');
    Logger.log('$requestType STATUS CODE: ${response.statusCode}');
    Logger.log('$requestType RESPONSE BODY: ${response.body}');
    if (kIsWeb) {
      return;
    }
    if (response.statusCode >= 400) {
      await FirebaseCrashlytics.instance
          .setCustomKey('Get Endpoint', '$url with ${response.statusCode}');
      await FirebaseCrashlytics.instance
          .setCustomKey('Response', response.body);
    }
    await FirebaseCrashlytics.instance.log(
      '$url with ${response.statusCode} \n Response:  ${response.body}',
    );
  }
}
