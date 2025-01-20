import 'package:get/get.dart';

class CommonController extends GetxController {
  void onHomeItemTapped(String title) {
    if (title.contains("Regular")) {
      Get.toNamed('/pos');
    } else if (title == "Restaurant") {
      Get.toNamed('/restaurant');
    } else if (title.contains("Fast")) {
      Get.toNamed('/fastFood');
    } else if (title.contains("Market")) {
      Get.toNamed('/super_market');
    } else if (title.contains("Online")) {
      Get.toNamed('/onlineStore');
    }
  }

  void onRestaurantItemTapped(String title) {
    if (title.contains("New")) {
      Get.toNamed('/new_order');
    } else if (title.contains("Active")) {
      Get.toNamed('/active_order');
    } else {
      Get.toNamed('/kitchen');
    }
  }

  void onNewOrderItemTapped(String title) {
    if (title.contains("Dine")) {
      Get.toNamed('/tables', arguments: {"title": "Tables"});
    } else {
      Get.toNamed('/fastFood', arguments: {"title": "Delivery"});
    }
  }

  void onActiveOrderItemTapped(String title) {
    if (title.contains("Dine")) {
      Get.toNamed('/tables', arguments: {"title": "Active Tables"});
    } else {
      Get.toNamed('/delivery');
    }
  }
}
