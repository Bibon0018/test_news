import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_news/api/api_client.dart';
import 'package:test_news/helpers/error_handler.dart';
import 'package:test_news/models/news_model.dart';
import 'package:test_news/models/news_type_enum.dart';

class HomeController extends GetxController {
  final ApiClient apiClient;
  RxList<NewsModel> feed = RxList<NewsModel>();
  RxList<NewsModel> top = RxList<NewsModel>();
  RxList<NewsModel> article = RxList<NewsModel>();

  HomeController(this.apiClient);

  final PagingController<int, NewsModel> pagingFeedController =
      PagingController(firstPageKey: 0);
  final PagingController<int, NewsModel> pagingTopController =
      PagingController(firstPageKey: 0);
  final PagingController<int, NewsModel> pagingArticleController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() async {
    await getNewsList(NewsType.feed);
    await getNewsList(NewsType.top);
    await getNewsList(NewsType.article);

    pagingFeedController.addPageRequestListener((pageKey) {
      _fetchPage(NewsType.feed);
    });
    pagingTopController.addPageRequestListener((pageKey) {
      _fetchPage(NewsType.top);
    });
    pagingArticleController.addPageRequestListener((pageKey) {
      _fetchPage(NewsType.article);
    });
    super.onInit();
  }

  Future<void> _fetchPage(
    NewsType type,
  ) async {
    final pagingController = currentPaginationController(type);
    final newsList = currentNewsList(type);
    try {
      final newItems = await apiClient.getNewsList(type, newsList.last.date);

      final isLastPage = newItems.length < 20;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = newsList.length;

        pagingController.appendPage(newItems, nextPageKey);
      }
      newsList.addAll(newItems);
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> getNewsList(NewsType newsType) async {
    try {
      final result = await apiClient.getNewsList(newsType, null);

      newsParse(
        currentNewsList(newsType),
        result,
        currentPaginationController(newsType),
      );
    } catch (e, s) {
      ErrorHandler.logError(e, s);
    }
  }

  void newsParse(RxList<NewsModel> news, List<NewsModel> result,
      PagingController<int, NewsModel> pagingController) {
    news.addAll(result);
    pagingController.refresh();
    pagingController.appendPage(result, news.length);
  }


  RxList<NewsModel> currentNewsList(NewsType type) {
    switch (type) {
      case NewsType.feed:
        return feed;
      case NewsType.top:
        return top;
      case NewsType.article:
        return article;
      default:
        return feed;
    }
  }

  PagingController<int, NewsModel> currentPaginationController(NewsType type) {
    switch (type) {
      case NewsType.feed:
        return pagingFeedController;
      case NewsType.top:
        return pagingTopController;
      case NewsType.article:
        return pagingArticleController;
      default:
        return pagingFeedController;
    }
  }
}
