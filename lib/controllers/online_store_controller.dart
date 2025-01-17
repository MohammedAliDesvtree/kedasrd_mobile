import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:kedasrd/utils/constants.dart';

class OnlineStoreController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isVisible = false.obs;

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

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    isVisible.value = false;
    isLoading.value = true;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  void onClose() {
    super.onClose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
  }
}
