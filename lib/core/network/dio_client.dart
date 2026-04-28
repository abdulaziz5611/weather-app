import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio.options
      ..connectTimeout = const Duration(seconds: ApiConstants.connectTimeoutSeconds)
      ..receiveTimeout = const Duration(seconds: ApiConstants.receiveTimeoutSeconds)
      ..headers = {'Content-Type': 'application/json'};
  }
}
