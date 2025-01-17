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
}
