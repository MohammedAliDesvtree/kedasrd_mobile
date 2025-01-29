import 'package:get/get.dart';

class SuperMarketController extends GetxController {
  bool isKeyboardVisible = false;
  RxBool isDigitsViewVisible = false.obs;

  var selectedItems = <String>{}.obs;

  @override
  void dispose() {
    super.dispose();
    isDigitsViewVisible = false.obs;
  }

  void toggleSelection(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }
}
