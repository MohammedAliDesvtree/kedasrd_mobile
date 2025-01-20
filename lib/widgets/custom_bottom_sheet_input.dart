import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

bool isKeyboardVisible = false;

class CustomBottomSheetInput extends StatelessWidget {
  final String title, hintText, btnText1;
  final String? btnText2;
  const CustomBottomSheetInput(
      {super.key,
      required this.title,
      required this.hintText,
      required this.btnText1,
      this.btnText2});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    double modalSize = !isPortrait
        ? 0.75
        : isKeyboardVisible
            ? 0.6
            : title.contains("Cash")
                ? 0.46
                : 0.3;
    return DraggableScrollableSheet(
      initialChildSize: modalSize, // Opens at 1/3 screen height
      minChildSize: modalSize, // Minimum 1/3 screen height
      maxChildSize: modalSize, // Maximum full screen height
      snap: false,
      // snapSizes: const [0.3, 0.6, 0.9],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.circular(28.0),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromTop(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    title.contains("Cash") ? title.toUpperCase() : title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                ),
              ),
              closeButton(),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                child: inputView(),
              ),
              Positioned(
                bottom: 16.0,
                left: 24.0,
                right: 24.0,
                child: WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromBottom(),
                  child: SafeArea(
                    child: Column(
                      children: [
                        if (title.contains("Cash"))
                          Column(
                            children: [
                              Container(
                                width: Get.width,
                                padding: const EdgeInsets.all(14.0),
                                decoration: BoxDecoration(
                                  color: Themes.kWhiteColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Themes.kBlackColor.withOpacity(0.20),
                                      blurRadius: 8.0,
                                      spreadRadius: -3,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    amountView("Total", "\$120.87"),
                                    const SizedBox(height: 2.0),
                                    amountView("Change", "\$0.00"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        Row(
                          mainAxisAlignment:
                              btnText2 != null && btnText2!.isNotEmpty
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.center,
                          children: [
                            submitButton(btnText1, context),
                            if (btnText2 != null && btnText2!.isNotEmpty)
                              submitButton(btnText2!, context)
                          ],
                        ),
                        if (title.contains("Cash"))
                          Column(
                            children: [
                              const SizedBox(height: 16.0),
                              submitButton("More Options", context),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget titleView(String title) {
    return GestureDetector(
      onTap: () {
        Get.back();
        Get.toNamed('/keypad_screens', arguments: {"title": "Cash"});
      },
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Themes.kPrimaryColor,
        ),
      ),
    );
  }

  Widget amountView(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$key :",
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Themes.kPrimaryColor,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Themes.kBlackColor,
          ),
        ),
      ],
    );
  }

  Widget closeButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(),
        child: Material(
          color: Themes.kTransparent,
          child: InkWell(
            onTap: () => Get.back(),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(28.0),
              bottomLeft: Radius.circular(28.0),
              topLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Themes.kPrimaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28.0),
                  bottomLeft: Radius.circular(28.0),
                  topLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: Container(
                height: 54.0,
                width: 54.0,
                padding: const EdgeInsets.all(21.0),
                child: Image.asset(
                  Images.close,
                  color: Themes.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 84.0),
      decoration: BoxDecoration(
        color: Themes.kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: TextFormField(
        autofocus: true,
        initialValue: title.contains("Cash") ? "\$120.87" : "",
        keyboardType:
            title.contains("Cash") ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Themes.kGreyColor[500],
          ),
        ),
      ),
    );
  }

  Widget submitButton(String title, context) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        onTap: () {
          if (title == "More Options") {
            Get.back();
            Get.toNamed('/keypad_screens', arguments: {"title": "Cash"});
          } else if (title == "Submit") {
            Constants.showSnackBar(context, "Submit Successfully!");
            Get.back();
          } else {
            Get.back();
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Container(
            height: 52.0,
            width: btnText2 != null && btnText2!.isNotEmpty
                ? Get.width / 2.5
                : Get.width / 2,
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
