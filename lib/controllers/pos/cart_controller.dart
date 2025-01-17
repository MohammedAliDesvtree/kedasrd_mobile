import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/models/cart_item_model.dart';

class CartController extends GetxController {
  bool isKeyboardVisible = false;
  RxBool isDigitsViewVisible = false.obs;
  RxBool isSearchVisible = false.obs;
  RxBool isDiscountFieldVisible = false.obs;
  RxDouble subtotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble total = 0.0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final TextEditingController qtyController = TextEditingController();
  RxString qty = "0".obs;
  RxDouble discountPercentage = 0.0.obs;

  @override
  void dispose() {
    super.dispose();
    isDigitsViewVisible = false.obs;
  }

  void searchToggle() {
    isSearchVisible.value = !isSearchVisible.value;
  }

  void deleteItem(int index) async {
    // First trigger the outgoing animation
    cartItems[index].isVisible = false;
    cartItems.refresh();

    // Wait for animation to complete before removing from list
    await Future.delayed(const Duration(milliseconds: 300));

    cartItems.removeAt(index);
    calculateTotals();
  }

  void updateQuantity(int index, bool increase) {
    if (increase) {
      cartItems[index].quantity++;
    } else if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }

    cartItems.refresh();
    calculateTotals();
  }

  void calculateTotals() {
    double discountValue = 0.0;
    subtotal.value = cartItems.fold(
        0.0, (sum, item) => sum + (item.price.value * item.quantity.value));
    tax.value = subtotal.value * 0.18; // Example: 18% tax
    discountValue = subtotal.value * (discountPercentage.value / 100);
    total.value = (subtotal.value + tax.value) - discountValue;
  }

  clearCart() {
    cartItems.clear();
    qtyController.text = "";
    qty.value = "0";
    calculateTotals();

    Get.back();
  }
}
