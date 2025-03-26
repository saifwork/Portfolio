import 'package:portfolio/data/models/config.dart';
import 'package:portfolio/data/models/contact.dart';

import '../api/apiHandler.dart';
import '../api/appConfigConstants.dart';
import 'package:logger/logger.dart';

import '../models/response_wrapper/api_response.dart';

class PortfolioRepo {
  String baseUrl = Constants.portfolioBaseUrl;
  var logger = Logger();

  Future<ApiResponse<String>> saveMessage(Contact body) async {
    try {
      logger.e("inside create saveMessage");

      print(body.toJson());

      final response = await ApiHandler().postData(
        baseUrl: baseUrl,
        endUrl: Constants.postContact,
        data: body.toJson(),
      );

      print(response.toString());

      if (isResponseSuccess(response.data)) {
        return ApiResponse<String>(
            data: '"Will get back to you shortly!', success: true);
      } else {
        return handleErrorResponse<String>(response);
      }
    } on Exception catch (e) {
      return ApiResponse<String>(
          error: ErrorResponse(0, 'An error occurred: $e'), success: false);
    }
  }

  Future<ApiResponse<Config>> getConfig() async {
    try {
      logger.e("inside get Config");

      final response = await ApiHandler().getData(
        baseUrl: baseUrl,
        endUrl: Constants.getConfig,
      );

      print(response);

      if (isResponseSuccess(response.data)) {
        final res = configFromJson(response.data);
        return ApiResponse<Config>(data: res, success: true);
      } else {
        return handleErrorResponse<Config>(response);
      }
    } on Exception catch (e) {
      logger.e(e);
      return ApiResponse<Config>(
          error: ErrorResponse(0, 'An error occurred: $e'), success: false);
    }
  }
}
