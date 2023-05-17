import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_news/helpers/error_handler.dart';
import 'package:test_news/models/news_detail_model.dart';
import 'package:test_news/models/news_model.dart';
import 'package:test_news/models/news_type_enum.dart';

class ApiClient extends GetxController {
  final Dio dio = Dio(
    BaseOptions(baseUrl: "https://sarnovosti.ru/api"),
  );

  static String getNewsListPath(String? id, DateTime? date) =>
      "/list.php?${getPathDateArg(date)}${getPathIdArg(id)}";

  static String getNewsDetailPath(String id) => "/news.php?id=$id";

  static String getPathIdArg(String? id) => id != null ? "&catId=$id" : "";

  static String getPathDateArg(DateTime? date) =>
      date != null ? "from=${DateFormat("ddMMyyHHmmss").format(date)}" : "";

  Future<List<NewsModel>> getNewsList(NewsType newsType, DateTime? date) async {
    try {
      final response = await dio.get(getNewsListPath(newsType.id, date));

      return (response.data as List)
          .map((x) => NewsModel.fromMap(Map<String, dynamic>.from(x)))
          .toList();
    } catch (e, s) {
      ErrorHandler.logError(e, s);
      return [];
    }
  }

  Future<NewsDetailModel?> getNewsDetail(String id) async {
    try {
      final response = await dio.get(getNewsDetailPath(id));

      return NewsDetailModel.fromMap(
          Map<String, dynamic>.from(response.data['data']));
    } catch (e, s) {
      ErrorHandler.logError(e, s);
      return null;
    }
  }
}
