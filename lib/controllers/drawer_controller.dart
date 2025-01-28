import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/custom_dialog.dart';

import 'package:kedasrd/utils/constants.dart';

class DrawerMenuController extends GetxController {
  int selectedIndex = -1.obs;

  @override
  void dispose() {
    super.dispose();
    selectedIndex = -1;
  }

  void onMenuItemTapped(String title, int index, BuildContext context) {
    // selectedIndex = index;
    Get.back();

    if (title == "Home") {
      // Home
    } else if (title == "Active Order") {
      Get.toNamed('/active_order');
    } else if (title == "New Order") {
      Get.toNamed('/new_order');
    } else if (title == "Kitchen") {
      Get.toNamed('/kitchen');
    } else if (title == "Table") {
      Get.toNamed('/tables', arguments: {"title": "Tables"});
    } else if (title == "Categories") {
      Get.toNamed('/fastFood');
    } else if (title == "Orders") {
      Get.toNamed('/orders');
    } else if (title == "Shifts") {
      Get.toNamed('/shifts');
    } else if (title == "Setting") {
      Get.toNamed('/settings');
    } else if (title == "Help") {
      // Help
    } else if (title == "Contact") {
      Get.toNamed('/contact');
    } else if (title == "Items") {
      Get.toNamed('/all_items', arguments: {"title": "Items"});
    } else if (title == "Customers") {
      Get.toNamed('/all_items', arguments: {"title": "Customers"});
    } else if (title == "Discount") {
      Constants.addDiscount(context);
    } else if (title.contains("Discard")) {
      Constants.discardOrder(context);
    } else if (title == "Exit") {
      logout(context, "Exit");
    } else if (title == "Logout") {
      logout(context, "Logout");
    }
  }

  void onCloseShiftTapped(BuildContext context, Size size, bool isPortrait) {
    Get.back();
    Constants.enterAuthCode(
        context: context, isPortrait: isPortrait, size: size, screen: "Drawer");
  }

  dynamic logout(BuildContext context, String type) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomDialog(
            title: "Confirmation",
            msg:
                "Are you sure you want to ${type == "Exit" ? "Exit" : "logout"} ?",
            positiveAction: () => Get.offAllNamed('/home')));
  }
}
