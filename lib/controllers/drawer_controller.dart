import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd/utils/constants.dart';

import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/widgets/custom_dialog.dart';
import 'package:kedasrd/widgets/custom_bottom_sheet_input.dart';
import 'package:kedasrd/widgets/custom_bottom_sheet_shifts.dart';

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
    } else if (title == "Items") {
      Get.toNamed('/all_items', arguments: {"title": "Items"});
    } else if (title == "Customers") {
      Get.toNamed('/all_items', arguments: {"title": "Customers"});
    } else if (title == "Discount") {
      addDiscount(context);
    } else if (title.contains("Discard")) {
      discardOrder(context);
    } else if (title == "Exit") {
      logout(context, "Exit");
    } else if (title == "Logout") {
      logout(context, "Logout");
    }
  }

  void onCloseShiftTapped(BuildContext context) {
    Get.back();
    closeShift(context);
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

  dynamic addDiscount(context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) => const CustomBottomSheetInput(
        title: "Add Discount",
        hintText: "Discount",
        btnText1: "Cancel",
        btnText2: "Submit",
      ),
    );
  }

  dynamic closeShift(context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) => const CustomBottomSheetShifts(
        title: "Close Shift",
        hintText: "Observations",
        btnText1: "Submit",
        btnText2: "Close and Print",
      ),
    );
  }

  dynamic discardOrder(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomDialog(
            title: 'Discard Order',
            msg: 'Are you sure or want to cancel your cart?',
            positiveAction: () {
              Constants.showSnackBar(context, "Order Discarded!");
              Get.back();
            }));
  }
}
