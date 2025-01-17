import 'package:get/get.dart';

class DineInController extends GetxController {
  var selectedTabIndex = 0.obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
