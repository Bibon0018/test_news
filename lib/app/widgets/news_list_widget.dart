import 'package:flutter/material.dart';
import 'package:test_news/app/presentation/modules/news_detail/views/news_detail_view.dart';
import 'package:test_news/app/widgets/news_widget.dart';
import 'package:test_news/models/news_model.dart';
import 'package:test_news/styles/colors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NewsListWidget extends StatelessWidget {
  final List<NewsModel> newsList;
  final PagingController<int, NewsModel> pagingController;
  final Future<void> Function() onRefresh;
  const NewsListWidget({
    super.key,
    required this.newsList,
    required this.pagingController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.mainColor,
      onRefresh: onRefresh,
      child: PagedListView<int, NewsModel>(
        physics: const BouncingScrollPhysics(),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<NewsModel>(
          itemBuilder: (context, item, index) => ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.grey;
                } else {
                  return Colors.white;
                }
              }),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: () => showNewsDetail(item.id),
            child: NewsWidget(
              img: item.img,
              dateTime: item.date,
              title: item.title,
              isImportant: item.important,
            ),
          ),
        ),
      ),
    );
  }
}
