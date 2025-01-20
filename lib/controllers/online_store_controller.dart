import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:kedasrd/utils/constants.dart';

class OnlineStoreController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isVisible = false.obs;
  RxBool isSearchVisible = false.obs;
  var selectedTabIndex = 0.obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  final Uri url = Uri.parse(Constants.onlineStoreURL);

  Future<void> openOnlineStore() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 2500), () {
      isVisible.value = true;
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      isLoading.value = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    isVisible.value = false;
    isLoading.value = true;
  }

  var selectedItems = <String>{}.obs;

  void toggleSelection(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }
}
