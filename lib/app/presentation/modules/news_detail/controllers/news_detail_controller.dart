import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_news/api/api_client.dart';
import 'package:test_news/helpers/error_handler.dart';
import 'package:test_news/models/news_detail_model.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailController extends GetxController {
  final ApiClient apiClient;
  final String id;

  NewsDetailController(this.apiClient, this.id);

  final PageController pageController = PageController();

  final Rxn<NewsDetailModel> newsDetail = Rxn<NewsDetailModel>();
  final RxBool isLoading = true.obs;
  final RxInt currentPage = 0.obs;

  @override
  void onInit() {
    getNewsDetail();
    super.onInit();
  }

  Future<void> getNewsDetail() async {
    try {
      final result = await apiClient.getNewsDetail(id);
      if (result != null) {
        newsDetail.value = result;
      }
    } catch (e, s) {
      ErrorHandler.logError(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void share() {
    if (newsDetail.value != null) {
      Share.share(newsDetail.value!.url);
    }
  }
}
