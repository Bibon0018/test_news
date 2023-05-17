import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_news/api/api_client.dart';
import 'package:test_news/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:test_news/app/presentation/modules/home/views/home_view.dart';
import 'package:test_news/styles/colors.dart';

void main() {
  Get.put(ApiClient());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: "RobotoSlab",
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainColor,
        ),
      ),
      home: GetBuilder(
        builder: (controller) => const HomeView(),
        init: HomeController(Get.find()),
      ),
    );
  }
}
