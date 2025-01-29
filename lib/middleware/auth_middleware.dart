import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/controllers/auth/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    return !authController.checkLoginStatus()
        ? const RouteSettings(name: Routes.SIGN_IN)
        : null;
  }
}
