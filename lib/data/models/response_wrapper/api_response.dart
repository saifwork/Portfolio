import 'dart:convert';
import 'package:dio/dio.dart';

class ApiResponse<T> {
  final T? data;
  final bool success;
  final ErrorResponse? error;

  ApiResponse({this.data, required this.success, this.error});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    return ApiResponse<T>(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      success: json['success'],
      error:
          json['error'] != null ? ErrorResponse.fromJson(json['error']) : null,
    );
  }
}

class ErrorResponse {
  final int code;
  final String message;

  ErrorResponse(this.code, this.message);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      json['code'] ?? 0,
      json['message'] ?? 'Unknown error',
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
      };
}

bool isResponseSuccess(dynamic responseData) {
  try {
    final Map<String, dynamic> jsonResponse =
        responseData is String ? jsonDecode(responseData) : responseData;
    return jsonResponse['success'] == true;
  } catch (e) {
    return false;
  }
}

ApiResponse<T> handleErrorResponse<T>(Response<dynamic> jsonData) {
  print("inside handleErrorResponse");
  try {
    final jsonResponse = jsonData.data as Map<String, dynamic>;

    if (jsonResponse['error'] != null) {
      final errorCode = jsonResponse['error']['code'];
      final errorMessage = jsonResponse['error']['message'];

      return ApiResponse<T>(
          error: ErrorResponse(errorCode, errorMessage), success: false);
    } else {
      return ApiResponse<T>(
          error: ErrorResponse(0, 'An unknown error occurred.'),
          success: false);
    }
  } catch (e) {
    return ApiResponse<T>(
        error: ErrorResponse(0, 'An unknown error occurred.'), success: false);
  }
}
