import 'package:get/get.dart';

class ShiftsController extends GetxController {
  var isExpanded = <int, bool>{}.obs;

  void toggleExpansion(int index) {
    isExpanded.forEach((key, value) {
      if (key != index) {
        isExpanded[key] = false;
      }
    });
    isExpanded[index] = !isExpanded[index]!;
  }

  @override
  void onInit() {
    super.onInit();
    isExpanded[0] = true;
    for (int i = 1; i < 7; i++) {
      isExpanded[i] = false;
    }
  }
}
