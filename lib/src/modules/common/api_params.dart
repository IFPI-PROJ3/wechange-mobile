import 'package:dio/dio.dart';

class ApiParams {
  static String apiBaseUrl = "http://wechange-api-b-env.eba-mkr492g5.sa-east-1.elasticbeanstalk.com";
  //static String apiBaseUrl = "https://192.168.118.1:7005";
  static String s3BucketBaseUrl = "https://wechange-images-bucket.s3.sa-east-1.amazonaws.com";
  static Options dioRequestDefaultOptions = Options(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    validateStatus: (status) {
      return status! < 500;
    },
  );

  static Options dioRequestDefaultOptionsAuthBearer(String accessToken) {
    Options options = dioRequestDefaultOptions;
    options.headers = {'Authorization': 'Bearer $accessToken'};

    return options;
  }
}
