import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_news/app/widgets/skeleton_container.dart';
import 'package:test_news/styles/colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_iframe/flutter_html_iframe.dart';
import '../controllers/news_detail_controller.dart';
import 'package:skeleton_text/skeleton_text.dart' as sm;

Future<void> showNewsDetail(String id) async {
  final controller = NewsDetailController(Get.find(), id);
  Get.to(() => GetBuilder(
        init: controller,
        builder: (controller) => const NewsDetailView(),
      ));
}

class NewsDetailView extends GetView<NewsDetailController> {
  const NewsDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: const Text('Aa'),
          leading: InkWell(
            splashColor: AppColors.transparentColor,
            onTap: Get.back,
            child: const Icon(Icons.keyboard_arrow_left_rounded, size: 32),
          ),
          actions: [
            InkWell(
              splashColor: AppColors.transparentColor,
              onTap: () => controller.share(),
              child: const Icon(
                Icons.ios_share_rounded,
              ),
            ).paddingOnly(right: 16)
          ],
          centerTitle: true,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.isLoading.value) ...buildSkeleton(context),
                if (!controller.isLoading.value &&
                    controller.newsDetail.value != null)
                  ...buildBody(
                    context,
                  )
              ],
            ).paddingAll(16),
          ),
        ),
      ),
    );
  }

  List<Widget> buildBody(BuildContext context) => [
        Image.network(controller.newsDetail.value!.img,
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SkeletonContainer.square(width: Get.width, height: 200);
        }),
        Text(
          DateFormat("HH:mm, dd MMMM yyyy ")
              .format(controller.newsDetail.value!.date)
              .toLowerCase(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.dateTextColor,
              ),
        ).paddingOnly(top: 16, bottom: 8),
        Text(
          controller.newsDetail.value!.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Container(
          width: Get.width,
          height: 1,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.separatorColor)),
        ).paddingSymmetric(vertical: 16),
        htmlText(),
        if (controller.newsDetail.value!.gallery.isNotEmpty)
          SizedBox(
            height: 160,
            width: Get.width,
            child: PageView(
              onPageChanged: (i) => controller.currentPage.value = i,
              controller: controller.pageController,
              children: [
                ...controller.newsDetail.value!.gallery.map(
                  (e) => Image.network(e.bigImg),
                )
              ],
            ),
          ),
        if (controller.newsDetail.value!.gallery.length > 1)
          Text(
              "${controller.currentPage.value + 1} из ${controller.newsDetail.value!.gallery.length}")
      ];

  List<Widget> buildSkeleton(BuildContext context) => [
        SkeletonContainer.square(
          width: Get.width,
          height: 200,
        ),
        const SizedBox(height: 16),
        SkeletonContainer.square(
          color: AppColors.dateTextColor.withOpacity(0.2),
          width: 100,
          height: 16,
        ),
        const SizedBox(height: 8),
        ...List.generate(
          3,
          (index) => SkeletonContainer.square(
            width: Get.width,
            height: 30,
          ).paddingOnly(top: 8),
        ),
        Container(
          width: Get.width,
          height: 1,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.separatorColor)),
        ).paddingSymmetric(vertical: 16),
        ...List.generate(
          15,
          (index) => SkeletonContainer.square(
            width: Get.width,
            height: 16,
          ).paddingOnly(top: 8),
        )
      ];

  Widget htmlText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Html(
        data: controller.newsDetail.value!.text,
        extensions: const [
          IframeHtmlExtension(),
        ],
      ),
    );
  }
}
