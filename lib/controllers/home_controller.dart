import 'package:get/get.dart';

class HomeController {
  void onItemTapped(String title) {
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
}
