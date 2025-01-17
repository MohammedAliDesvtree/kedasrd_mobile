import 'package:get/get.dart';

import 'package:kedasrd/utils/dummy_data.dart';

class FilterController extends GetxController {
  var selectedIndex = (-1).obs;

  List<bool> isVisibleItems =
      List.generate(DummyData.filterItems.length, (_) => false).obs;

  void selectFilter(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = -1;
    } else {
      selectedIndex.value = index;
    }
    Get.back();
  }

  Future<void> animatedFilterList() async {
    for (int i = 0; i < isVisibleItems.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      isVisibleItems[i] = true;
    }
  }
}
