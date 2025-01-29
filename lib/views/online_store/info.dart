import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_text_input.dart';

import 'package:kedasrd/views/online_store/payment_info_view.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            submitButton("Continue Shopping", size),
            submitButton("Submit Order", size),
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const CustomHeader(title: "New Customer"),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: size.height / 2.5,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      isPortrait
                          ? const Column(
                              children: [
                                CustomTextInput(
                                    hintText: "Name", isNumber: false),
                                SizedBox(height: 16.0),
                                CustomTextInput(
                                    hintText: "Phone Number", isNumber: true),
                                SizedBox(height: 16.0),
                                CustomTextInput(
                                    hintText: "Email Address", isNumber: false),
                                SizedBox(height: 16.0),
                                CustomTextInput(
                                    hintText: "Address", isNumber: false),
                              ],
                            )
                          : const Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomTextInput(
                                            hintText: "Name", isNumber: false)),
                                    SizedBox(width: 14.0),
                                    Expanded(
                                        child: CustomTextInput(
                                            hintText: "Phone Number",
                                            isNumber: true)),
                                  ],
                                ),
                                SizedBox(height: 14.0),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomTextInput(
                                            hintText: "Email Address",
                                            isNumber: false)),
                                    SizedBox(width: 14.0),
                                    Expanded(
                                        child: CustomTextInput(
                                            hintText: "Address",
                                            isNumber: false)),
                                  ],
                                ),
                                SizedBox(height: 14.0),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget submitButton(String title, Size size) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          if (title.contains("Submit")) {
            showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true, // To allow full screen dragging
              backgroundColor: Themes.kTransparent,
              builder: (context) {
                return const PaymentInfoView();
              },
            );
          } else {
            Get.toNamed(Routes.ONLINE_STORE);
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            height: 54.0,
            width: size.width / 2.2,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
