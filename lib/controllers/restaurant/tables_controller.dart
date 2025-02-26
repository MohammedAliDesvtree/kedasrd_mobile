import 'dart:math';
import 'package:get/get.dart';

class TablesController extends GetxController {
  RxList<int> randomNumbers = <int>[].obs;
  final RxInt selectedTabIndex = 0.obs;

  // Add observable strings for each dropdown
  final RxMap<String, String> dropdownValues = <String, String>{}.obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
    // Clear all dropdown selections
    dropdownValues.clear();
  }

  void resetTab() {
    // Reset to initial state (0 index)
    selectedTabIndex.value = 0;
  }

  void setDropdownValue(String key, String value) {
    dropdownValues[key] = value;
  }

  String? getDropdownValue(String key) {
    return dropdownValues[key];
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

    // Initialize tab index to 0 explicitly
    selectedTabIndex.value = 0;

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
