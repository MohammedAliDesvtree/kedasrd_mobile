import 'package:get/get.dart';

class FastFoodController extends GetxController {
  bool isKeyboardVisible = false;
  bool isDigitsViewVisible = false;

  var selectedItems = <String>{}.obs;

  void toggleSelection(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  // Add this to track expanded items
  final RxMap<int, bool> expandedItems = <int, bool>{}.obs;

  void toggleItemExpansion(int index) {
    if (expandedItems.containsKey(index)) {
      expandedItems[index] = !expandedItems[index]!;
    } else {
      expandedItems[index] = true;
    }
  }
}
