import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';

class CustomBottomSheetShifts extends StatelessWidget {
  final String title, hintText, btnText1;
  final String? btnText2;
  const CustomBottomSheetShifts(
      {super.key,
      required this.title,
      required this.hintText,
      required this.btnText1,
      this.btnText2});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    double modalSize = isPortrait ? 0.48 : 0.75;

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
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                ),
              ),
              closeButton(),
              Container(
                height: 132.0,
                margin:
                    const EdgeInsets.only(top: 74.0, left: 24.0, right: 24.0),
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Themes.kGreyColor)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textStyle("Start Date", "bold"),
                        textStyle("12/24/2024 12:15 AM", "normal"),
                      ],
                    ),
                    divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textStyle("Initial Base", "bold"),
                        textStyle("DOP \$0.00", "normal"),
                      ],
                    ),
                    divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textStyle("Total", "bold"),
                        textStyle("DOP \$0.00", "bold"),
                      ],
                    ),
                  ],
                ),
              ),
              WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                  child: inputView()),
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

  Widget divider() {
    return Container(
      height: 0.5,
      width: Get.width,
      color: Themes.kGreyColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  Widget textStyle(String title, String type) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: type == "bold" ? FontWeight.bold : FontWeight.normal,
        color: Themes.kBlackColor,
      ),
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
      margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 224.0),
      decoration: BoxDecoration(
        color: Themes.kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: TextFormField(
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
          if (title == "Submit") {
            Constants.showSnackBar(context, "Submit Successfully!");
          } else {
            Constants.showSnackBar(context, "Print Successfully!");
          }
          Get.back();
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
