import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/models/cart_item_model.dart';

import 'package:kedasrd/controllers/pos/cart_controller.dart';

class POSController extends GetxController {
  final CartController cartController = Get.find<CartController>();
  RxBool isSearchVisible = false.obs;
  var filteredList = RxList<dynamic>(DummyData.productList);
  final TextEditingController searchController = TextEditingController();

  RxList<bool> isVisibleItems = RxList<bool>([]);

  Timer? _animationTimer;
  int _animationIndex = 0;

  @override
  void onInit() {
    super.onInit();
    filteredList.listen((newList) {
      _resetAnimation();
    });
    _resetAnimation();
  }

  void _resetAnimation() {
    isVisibleItems =
        RxList<bool>(List.generate(filteredList.length, (_) => false));
    _animationIndex = 0;
    _animationTimer?.cancel();
    _animationTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_animationIndex < isVisibleItems.length) {
        isVisibleItems[_animationIndex] = true;
        _animationIndex++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }

  void searchToggle() {
    isSearchVisible.value = !isSearchVisible.value;
  }

  void addToCart(String productName, int price, int qty) {
    // CartItemModel item = CartItemModel(
    //   name: "Nachitos Ricos",
    //   price: 354.00,
    //   quantity: 1,
    //   isVisible: true,
    // );
    // cartController.cartItems.add(item);

    try {
      // Check if the product already exists in the cart
      var existingItem = cartController.cartItems.firstWhere(
        (item) => item.name == productName,
      );

      // Increase the quantity of the existing item
      existingItem.quantity++;
    } catch (e) {
      // Add a new item to the cart with quantity 1
      CartItemModel item = CartItemModel(
        name: productName,
        price: price,
        quantity: qty,
        isVisible: true,
      );
      cartController.cartItems.add(item);
    }

    // Recalculate totals
    cartController.calculateTotals();
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      filteredList.value = DummyData.productList; // Display all items
    } else {
      filteredList.value = DummyData.productList
          .where((item) =>
              item['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
