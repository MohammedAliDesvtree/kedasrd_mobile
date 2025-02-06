import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FastFoodCartController extends GetxController {
  RxBool isDiscountFieldVisible = false.obs;
  RxBool isDigitsViewVisible = false.obs;
  final TextEditingController qtyController = TextEditingController();
  RxString qty = "".obs;

  RxBool isNameVisible = true.obs;

  // // Add this to track expanded items
  // final RxMap<int, bool> expandedItems = <int, bool>{}.obs;

  // void toggleItemExpansion(int index) {
  //   if (expandedItems.containsKey(index)) {
  //     expandedItems[index] = !expandedItems[index]!;
  //   } else {
  //     expandedItems[index] = true;
  //   }
  // }

  // Track the currently expanded item index
  final RxInt expandedIndex = RxInt(-1); // -1 means no item is expanded

  void toggleItemExpansion(int index) {
    // If tapping the currently expanded item, collapse it
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      // Otherwise, expand the tapped item (collapsing any other)
      expandedIndex.value = index;
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDigitsViewVisible = false.obs;
  }
}
