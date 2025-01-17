import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kedasrd/utils/dummy_data.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/widgets/custom_bottom_sheet_input.dart';

class CustomBottomSheetController extends GetxController {
  var selectedIndex = (-1).obs;

  List<bool> isVisibleItems =
      List.generate(DummyData.payItems.length, (_) => false).obs;

  @override
  void onInit() {
    super.onInit();
    animatedFilterList();
  }

  @override
  void dispose() {
    super.dispose();
    isVisibleItems = List.generate(DummyData.payItems.length, (_) => false).obs;
  }

  void selectFilter(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = -1;
    } else {
      selectedIndex.value = index;
    }
    Get.back();
  }

  Future<void> animatedFilterList() async {
    for (int i = 0; i < isVisibleItems.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      isVisibleItems[i] = true;
    }
  }

  void onTappedSpecificView(String title, BuildContext context) {
    if (title.contains("Prepaid")) {
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
