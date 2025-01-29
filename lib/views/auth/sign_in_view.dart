import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/custom_text_input.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/controllers/auth/auth_controller.dart';
import 'package:kedasrd/controllers/auth/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInController controller = Get.put(SignInController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64.0),
                Image.asset(Images.kedasLogo),
                const SizedBox(height: 36.0),
                CustomTextInput(
                  hintText: "Email Address",
                  isNumber: false,
                  isEmail: true,
                  controller: controller.emailController,
                ),
                const SizedBox(height: 24.0),
                Obx(
                  () => CustomTextInput(
                    hintText: "Password",
                    isNumber: false,
                    controller: controller.passwordController,
                    isSecure: controller.isPasswordShow.value,
                  ),
                ),
                const SizedBox(height: 84.0),
                submitButton(context, size, "Sign In".toUpperCase()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget submitButton(BuildContext context, Size size, String title) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: () => controller.handleLogin(context, authController),
        child: Ink(
          decoration: BoxDecoration(
              color: Themes.kPrimaryColor,
              borderRadius: BorderRadius.circular(6.0)),
          child: Container(
            height: 48.0,
            width: size.width,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
