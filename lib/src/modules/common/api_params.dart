import 'package:dio/dio.dart';

class ApiParams {
  static String apiBaseUrl = "http://wechange-api-b-env.eba-mkr492g5.sa-east-1.elasticbeanstalk.com";

  static Options dioRequestDefaultOptions = Options(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  static Options dioRequestDefaultOptionsAuthBearer(String refreshToken) {
    Options options = dioRequestDefaultOptions;
    options.headers = {'Authorization': 'Bearer $refreshToken'};

    return options;
  }
}
