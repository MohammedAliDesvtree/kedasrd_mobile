import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/constants.dart';

class DrawerMenuController extends GetxController {
  int selectedIndex = -1.obs;

  @override
  void dispose() {
    super.dispose();
    selectedIndex = -1;
  }

  void onMenuItemTapped(
      String title, int index, BuildContext context, dynamic authController) {
    // selectedIndex = index;
    Get.back();

    if (title == "Home") {
      // Home
    } else if (title == "Active Order") {
      Get.toNamed(Routes.ACTIVE_ORDER);
    } else if (title == "New Order") {
      Get.toNamed(Routes.NEW_ORDER);
    } else if (title == "Kitchen") {
      Get.toNamed(Routes.KITCHEN);
    } else if (title == "Bar") {
      Get.toNamed(Routes.BAR);
    } else if (title == "Table") {
      Get.toNamed(Routes.TABLES, arguments: {"title": "Tables"});
    } else if (title == "Categories") {
      Get.toNamed(Routes.FAST_FOOD);
    } else if (title == "Orders") {
      Get.toNamed(Routes.ORDERS);
    } else if (title == "Shifts") {
      Get.toNamed(Routes.SHIFTS);
    } else if (title == "Setting") {
      Get.toNamed(Routes.SETTINGS);
    } else if (title == "Help") {
      // Help
    } else if (title == "Contact") {
      Get.toNamed(Routes.CONTACT);
    } else if (title == "Items") {
      Get.toNamed(Routes.ALL_ITEMS, arguments: {"title": "Items"});
    } else if (title == "Customers") {
      Get.toNamed(Routes.ALL_ITEMS, arguments: {"title": "Customers"});
    } else if (title == "Discount") {
      Constants.addDiscount(context);
    } else if (title.contains("Discard")) {
      Constants.discardOrder(context);
    } else if (title == "Exit") {
      Constants.logout(context, authController, "Exit");
    } else if (title == "Logout") {
      Constants.logout(context, authController, "Logout");
    }
  }

  void onCloseShiftTapped(BuildContext context, Size size, bool isPortrait,
      dynamic authController) {
    Get.back();
    if (authController.isAdmin) {
      Constants.closeShift(context);
    } else {
      Constants.enterAuthCode(
          context: context,
          isPortrait: isPortrait,
          size: size,
          screen: "Drawer");
    }
  }
}
