import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

import 'package:kedasrd/widgets/custom_bottom_sheet_input.dart';

class SuperMarketCartController extends GetxController {
  void onTappedSpecificView(String title, BuildContext context) {
    if (title == "Prepaid") {
      Constants.showSnackBar(
          context, "ERROR", "The selected customer has insufficient balance.");
    } else if (title == "Cash") {
      openCashModal(context);
    } else {
      Get.toNamed(Routes.KEYPAD_SCREENS, arguments: {"title": title});
    }
  }

  dynamic openCashModal(context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) => const CustomBottomSheetInput(
        title: "Payment Type : Cash",
        hintText: "Amount",
        btnText1: "Complete Order Now",
      ),
    );
  }
}
