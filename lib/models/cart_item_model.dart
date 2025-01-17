import 'package:get/get.dart';

class CartItemModel {
  final String name;
  RxInt price;
  RxInt quantity;
  bool isVisible;

  CartItemModel({
    required this.name,
    required int price,
    int quantity = 1,
    this.isVisible = true,
  })  : price = price.obs,
        quantity = quantity.obs;
}
