import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SuperMarketController extends GetxController {
  bool isKeyboardVisible = false;
  RxBool isDigitsViewVisible = false.obs;

  var selectedItems = <String>{}.obs;

  @override
  void dispose() {
    super.dispose();
    isDigitsViewVisible = false.obs;
  }

  void toggleSelection(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  void onTabTapped(String title, BuildContext context) {
    // if (title.contains("Items")) {
    //   Get.toNamed('/all_items', arguments: {"title": "Items"});
    // } else if (title.contains("Customers")) {
    //   Get.toNamed('/all_items', arguments: {"title": "Customers"});
    // } else if (title.contains("Orders")) {
    //   Get.toNamed('/all_orders', arguments: {"title": "Orders"});
    // } else if (title.contains("Save")) {
    //   showSnackBar(context);
    // } else if (title.contains("Discard")) {
    //   discardOrder(context);
    // } else if (title == "Discount") {
    //   addDiscount(context);
    // }
  }

  showSnackBar(context) {
    var snackBar = const SnackBar(content: Text('Order Created Successfully!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
