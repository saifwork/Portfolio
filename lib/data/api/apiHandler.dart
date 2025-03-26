import 'dart:convert';
import 'package:dio/dio.dart';

class ApiHandler {
  Dio dio = Dio();

  Future<Response<dynamic>> postData({
    required String baseUrl,
    required String endUrl,
    required dynamic data,
    Map<String, String>? headers,
  }) async {
    try {
      final apiUrl = baseUrl + endUrl;

      print(apiUrl);
      Options options = createHeaders(headers);
      final String requestBody = jsonEncode(data);

      print("before calling api");

      final response = await dio.post(
        apiUrl,
        options: options,
        data: requestBody,
      );
      print("after calling api ${response.toString()}");

      return response;
    } catch (e) {
      print("inside catch ${e.toString()}");
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 500 ||
            e.response!.statusCode == 400 ||
            e.response!.statusCode == 404 ||
            e.response!.statusCode == 409) {
          return e.response!;
        }
      }
      throw Exception('error: $e');
    }
  }

  Future<Response<dynamic>> getData({
    required String baseUrl,
    required String endUrl,
    Map<String, String>? headers,
  }) async {
    try {
      final apiUrl = baseUrl + endUrl;

      print(apiUrl);

      Options options = createHeaders(headers);

      final response = await dio.get(
        apiUrl,
        options: options,
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 500 ||
            e.response!.statusCode == 400 ||
            e.response!.statusCode == 404) {
          return e.response!;
        }
      }
      throw Exception('error: $e');
    }
  }
  
  Options createHeaders(Map<String, String>? headers) {
    return Options(
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (headers != null) ...headers,
      },
    );
  }
}
