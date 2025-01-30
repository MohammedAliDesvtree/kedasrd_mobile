import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_text_input.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

import 'package:kedasrd/controllers/common_controller.dart';

class EntryLogView extends StatefulWidget {
  const EntryLogView({super.key});

  @override
  State<EntryLogView> createState() => _EntryLogViewState();
}

class _EntryLogViewState extends State<EntryLogView> {
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customHeader(),
            const SizedBox(height: 28.0),
            const Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Text(
                "Employees Entry Log",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Themes.kBlackColor,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    inputSection(),
                    const SizedBox(height: 148.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customButton("Cancel", context),
                        customButton("Submit", context),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        children: [
          const SizedBox(height: 24.0),
          Row(
            children: [
              Material(
                color: Themes.kTransparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(92.0),
                  child: Ink(
                    height: 92.0,
                    width: 92.0,
                    decoration: BoxDecoration(
                      color: Themes.kGreyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(92.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                "Upload your picture",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Themes.kBlackColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          const CustomTextInput(
            hintText: "Employees code to log entry",
            isNumber: true,
          ),
          const SizedBox(height: 24.0),
          const CustomTextInput(
            hintText: "Enter your initial balance",
            isNumber: true,
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () => commonController.locationAllowed(),
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Themes.kBlackColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: commonController.isLocationAllow.value
                        ? const Icon(Icons.check, size: 16.0)
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              const Text(
                "Allow Location",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Themes.kBlackColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget customButton(String title, BuildContext context) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          if (title == "Submit") {
            Get.toNamed(Routes.UPLOAD_PHOTO);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        child: Ink(
          decoration: BoxDecoration(
              color:
                  title == "Cancel" ? Themes.kGreyColor : Themes.kPrimaryColor,
              borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            height: 50.0,
            width: 160.0,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customHeader() {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(),
      child: Container(
        height: Constants.headerHeight,
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset(
                Images.leftArrow,
                height: 22.0,
                color: Themes.kBlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
