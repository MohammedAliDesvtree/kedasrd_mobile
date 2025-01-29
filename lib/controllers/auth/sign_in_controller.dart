import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/constants.dart';

class SignInController extends GetxController {
  RxBool isPasswordShow = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleLogin(BuildContext context, dynamic authController) async {
    final success = await authController.login(
      emailController.text,
      passwordController.text,
    );
    if (success) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Constants.showSnackBar(context, "ERROR", "Invalid credentials");
    }
  }

  void togglePassword() {
    isPasswordShow.value = !isPasswordShow.value;
  }
}
