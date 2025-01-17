import 'dart:math';
import 'package:get/get.dart';

class TablesController extends GetxController {
  RxList<int> randomNumbers = <int>[].obs;
  RxInt selectedTabIndex = 0.obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  void updateRandomNumbers(int tableLength) {
    final random = Random();
    randomNumbers = List.generate(
      tableLength,
      (_) => random.nextInt(10) + 1,
    ).obs;
  }

  @override
  void onInit() {
    super.onInit();
    ever(selectedTabIndex, (value) {
      int tableLength = getTableLength(value);
      updateRandomNumbers(tableLength);
    });
    // Initialize with the first tab's table length
    int initialTableLength = getTableLength(selectedTabIndex.value);
    updateRandomNumbers(initialTableLength);
  }

  int getTableLength(int index) {
    switch (index) {
      case 0:
        return 7;
      case 1:
        return 2;
      case 2:
        return 1;
      case 3:
        return 1;
      default:
        return 1;
    }
  }
}
