import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FastFoodCartController extends GetxController {
  RxBool isDiscountFieldVisible = false.obs;
  RxBool isDigitsViewVisible = false.obs;
  final TextEditingController qtyController = TextEditingController();
  RxString qty = "".obs;

  RxBool isNameVisible = true.obs;

  @override
  void dispose() {
    super.dispose();
    isDigitsViewVisible = false.obs;
  }
}
