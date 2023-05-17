import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> goFullScreen(List<String> images, Rx<int> currentImage) async {
  return await Get.to(
    () => Builder(
      builder: (context) =>
          FullScreenImageWidget(images: images, currentImage: currentImage),
    ),
  );
}

class FullScreenImageWidget extends StatelessWidget {
  final List<String> images;
  final Rx<int> currentImage;

  const FullScreenImageWidget(
      {Key? key, required this.images, required this.currentImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        PageController(initialPage: currentImage.value);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: SafeArea(
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Get.back(result: currentImage.value),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 48,
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (i) => currentImage.value = i,
        children: [...images.map((e) => Image.network(e).paddingAll(16))],
      ),
      bottomNavigationBar: Obx(
        () => images.length > 1
            ? Text(
                "${currentImage.value + 1} из ${images.length}",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: Colors.white),
              ).paddingOnly(bottom: MediaQuery.of(context).padding.bottom)
            : const SizedBox(),
      ),
    );
  }
}
