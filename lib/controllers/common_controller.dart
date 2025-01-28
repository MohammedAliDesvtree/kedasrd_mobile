import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/constants.dart';

class CommonController extends GetxController {
  RxBool isLocationAllow = false.obs;
  bool isKeyboardVisible = false;

  void onHomeItemTapped(
      BuildContext context, Size size, bool isPortrait, String title) {
    if (title.contains("Regular")) {
      Get.toNamed('/pos');
    } else if (title == "Restaurant") {
      Constants.enterAuthCode(
          context: context, isPortrait: isPortrait, size: size, screen: "Home");
    } else if (title.contains("Fast")) {
      Get.toNamed('/fastFood');
    } else if (title.contains("Market")) {
      Get.toNamed('/super_market');
    } else if (title.contains("Online")) {
      Get.toNamed('/onlineStore');
    }
  }

  void onRestaurantItemTapped(String title) {
    if (title.contains("New")) {
      Get.toNamed('/new_order');
    } else if (title.contains("Active")) {
      Get.toNamed('/active_order');
    } else {
      Get.toNamed('/kitchen');
    }
  }

  void onNewOrderItemTapped(
      BuildContext context, Size size, bool isPortrait, String title) {
    if (title.contains("Dine")) {
      Constants.enterAuthCode(
          context: context,
          isPortrait: isPortrait,
          size: size,
          screen: "New Order");
    } else {
      Get.toNamed('/fastFood', arguments: {"title": "Delivery"});
    }
  }

  void onActiveOrderItemTapped(String title) {
    if (title.contains("Dine")) {
      Get.toNamed('/tables', arguments: {"title": "Active Tables"});
    } else {
      Get.toNamed('/delivery');
    }
  }

  void locationAllowed() {
    isLocationAllow.value = !isLocationAllow.value;
  }
}
