import 'package:dio/dio.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/common/models/categories.dart';

class CategoryService {
  static Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    try {
      final response = await Dio().get(
        "${ApiParams.apiBaseUrl}/category/all",
        options: ApiParams.dioRequestDefaultOptions,
      );

      if (response.statusCode == 200) {
        response.data.forEach((v) {
          categories.add(Category.fromJson(v));
        });
      }
    } on Exception {}

    return categories;
  }
}
