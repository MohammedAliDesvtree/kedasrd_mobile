import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/constants.dart';

class CommonController extends GetxController {
  RxBool isLocationAllow = false.obs;
  bool isKeyboardVisible = false;

  void onHomeItemTapped(BuildContext context, Size size, bool isPortrait,
      String title, dynamic authController) {
    if (title.contains("Regular")) {
      Get.toNamed(Routes.POS);
    } else if (title == "Restaurant") {
      if (authController.isAdmin) {
        Get.toNamed(Routes.RESTAURANT);
      } else {
        Constants.enterAuthCode(
            context: context,
            isPortrait: isPortrait,
            size: size,
            screen: "Home");
      }
    } else if (title.contains("Fast")) {
      Get.toNamed(Routes.FAST_FOOD);
    } else if (title.contains("Market")) {
      Get.toNamed(Routes.SUPER_MARKET);
    } else if (title.contains("Online")) {
      Get.toNamed(Routes.ONLINE_STORE);
    }
  }

  void onRestaurantItemTapped(String title) {
    if (title.contains("New")) {
      Get.toNamed(Routes.NEW_ORDER);
    } else if (title.contains("Active")) {
      Get.toNamed(Routes.ACTIVE_ORDER);
    } else {
      Get.toNamed(Routes.KITCHEN);
    }
  }

  void onNewOrderItemTapped(BuildContext context, Size size, bool isPortrait,
      String title, dynamic authController) {
    if (title.contains("Dine")) {
      if (authController.isAdmin) {
        Get.toNamed(Routes.TABLES, arguments: {"title": "Tables"});
      } else {
        Constants.enterAuthCode(
            context: context,
            isPortrait: isPortrait,
            size: size,
            screen: "New Order");
      }
    } else {
      Get.toNamed(Routes.FAST_FOOD, arguments: {"title": "Delivery"});
    }
  }

  void onActiveOrderItemTapped(String title) {
    if (title.contains("Dine")) {
      Get.toNamed(Routes.TABLES, arguments: {"title": "Active Tables"});
    } else {
      Get.toNamed(Routes.DELIVERY);
    }
  }

  void locationAllowed() {
    isLocationAllow.value = !isLocationAllow.value;
  }
}
