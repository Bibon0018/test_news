import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_news/app/widgets/news_list_widget.dart';
import 'package:test_news/models/news_type_enum.dart';
import '../controllers/home_controller.dart';
import 'package:test_news/assets/svg.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: AppBar(
            centerTitle: true,
            title: SvgPicture.asset(AppSvg.logo, height: 24),
            actions: [
              const Icon(Icons.info_outline_rounded).paddingOnly(right: 16)
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(65.0),
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                labelPadding: EdgeInsets.zero,
                tabs: [
                  _buildTab(context, "Лента"),
                  _buildTab(context, "Важное"),
                  _buildTab(context, "Статьи"),
                ],
              ).paddingOnly(bottom: 6),
            ),
          ),
        ),
        body: Obx(
          () => TabBarView(
            children: [
              NewsListWidget(
                newsList: controller.feed.value,
                pagingController: controller.pagingFeedController,
                onRefresh: () => controller.getNewsList(NewsType.feed),
              ),
              NewsListWidget(
                newsList: controller.top.value,
                pagingController: controller.pagingTopController,
                onRefresh: () => controller.getNewsList(NewsType.top),
              ),
              NewsListWidget(
                newsList: controller.article.value,
                pagingController: controller.pagingArticleController,
                onRefresh: () => controller.getNewsList(NewsType.article),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String title) {
    return Tab(
      height: 24,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ).paddingSymmetric(horizontal: 16);
  }
}
