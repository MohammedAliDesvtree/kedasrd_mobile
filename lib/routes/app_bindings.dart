import 'package:get/get.dart';

import 'package:kedasrd/controllers/common_controller.dart';
import 'package:kedasrd/controllers/drawer_controller.dart';
import 'package:kedasrd/controllers/pos/pos_controller.dart';
import 'package:kedasrd/controllers/pos/cart_controller.dart';
import 'package:kedasrd/controllers/pos/filter_controller.dart';
import 'package:kedasrd/controllers/restaurant/tables_controller.dart';
import 'package:kedasrd/controllers/restaurant/dine_in_controller.dart';
import 'package:kedasrd/controllers/fastfood/fast_food_controller.dart';
import 'package:kedasrd/controllers/restaurant/kitchen_controller.dart';
import 'package:kedasrd/controllers/super_market/super_market_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CommonController());
    Get.put(CartController());
    Get.put(POSController());
    Get.put(FastFoodController());
    Get.put(FilterController());
    Get.put(SuperMarketController());
    Get.put(DineInController());
    Get.put(TablesController());
    Get.put(KitchenController());
    Get.put(DrawerMenuController());
  }
}
