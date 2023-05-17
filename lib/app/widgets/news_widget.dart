import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_news/app/widgets/skeleton_container.dart';
import 'package:test_news/styles/colors.dart';

class NewsWidget extends StatelessWidget {
  final String? img;
  final DateTime dateTime;
  final String title;
  final bool isImportant;

  const NewsWidget({
    Key? key,
    required this.img,
    required this.dateTime,
    required this.title,
    required this.isImportant,
  }) : super(key: key);

  final double imageRatio = 1;
  final double textRatio = 2;
  final double paddingHorizontal = 16;
  final double paddingVertical = 16;

  double get textWidth => imageIsNotEmpty
      ? (Get.width - (paddingHorizontal * 2)) *
          (textRatio / (imageRatio + textRatio))
      : Get.width - (paddingHorizontal * 2);

  bool get imageIsNotEmpty => (img != null && img != '');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.separatorColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: textWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("dd MMMM, HH:mm").format(dateTime).toLowerCase(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppColors.dateTextColor,
                      ),
                ).paddingOnly(bottom: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight:
                          isImportant ? FontWeight.bold : FontWeight.normal),
                ),
              ],
            ),
          ),
          if (imageIsNotEmpty)
            Container(
              alignment: Alignment.centerRight,
              width: 100,
              height: 60,
              child: Image.network(
                img!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SkeletonContainer.square(width: 100, height: 60);
                },
              ),
            ),
        ],
      ).paddingSymmetric(
        vertical: paddingVertical,
      ),
    );
  }
}
