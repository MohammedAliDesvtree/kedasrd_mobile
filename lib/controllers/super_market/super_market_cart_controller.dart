import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/widgets/custom_bottom_sheet_input.dart';

class SuperMarketCartController extends GetxController {
  void onTappedSpecificView(String title, BuildContext context) {
    if (title == "Prepaid") {
      showSnackBar(context);
    } else if (title == "Cash") {
      openCashModal(context);
    } else {
      Get.toNamed('/keypad_screens', arguments: {"title": title});
    }
  }

  showSnackBar(context) {
    var snackBar = const SnackBar(
        content: Text('The selected customer has insufficient balance.'),
        backgroundColor: Themes.kRedColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
