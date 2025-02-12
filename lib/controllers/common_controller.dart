import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/constants.dart';

class CommonController extends GetxController {
  RxBool isLocationAllow = false.obs;
  bool isKeyboardVisible = false;
  // Instead of single RxInt
  RxList<int> qtyValues = <int>[].obs;
  // Track the currently expanded item index
  final RxInt expandedIndex = RxInt(-1); // -1 means no item is expanded

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
    } else if (title == "Delivery") {
      Get.toNamed(Routes.DELIVERY);
    } else {
      Get.toNamed(Routes.FAST_FOOD, arguments: {"title": "Delivery"});
    }
  }

  void locationAllowed() {
    isLocationAllow.value = !isLocationAllow.value;
  }

  void toggleItemExpansion(int index) {
    // If tapping the currently expanded item, collapse it
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      // Otherwise, expand the tapped item (collapsing any other)
      expandedIndex.value = index;
    }
  }

  // Initialize the list with default quantities (do this when you load your items)
  // For example, in your init method or when you get your data:
  void initQuantities(int itemCount) {
    qtyValues = List.generate(itemCount, (index) => 1).obs;
  }

  // Modified updateQuantity method
  void updateQuantity(int index, bool increase) {
    if (increase) {
      qtyValues[index]++;
    } else if (qtyValues[index] > 1) {
      qtyValues[index]--;
    }

    // Trigger update
    qtyValues.refresh();
  }

  // In your controller initialization or when data loads
  @override
  void onInit() {
    super.onInit();
    // Assuming you have a list of items with length itemCount
    initQuantities(12);
  }
}
