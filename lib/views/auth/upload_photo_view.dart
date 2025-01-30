import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

class UploadPhotoView extends StatelessWidget {
  const UploadPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            customHeader(),
            const SizedBox(height: 28.0),
            const Text(
              "Take Your Picture to Finish",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                color: Themes.kBlackColor,
              ),
            ),
            const SizedBox(height: 42.0),
            uploadPhotoView(size, context),
            const SizedBox(height: 148.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customButton("Cancel"),
                customButton("Submit"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadPhotoView(Size size, BuildContext context) {
    return DottedBorder(
      color: Themes.kGreyColor,
      strokeWidth: 1,
      dashPattern: const [3],
      radius: const Radius.circular(4.0),
      child: Container(
        width: size.width - 64,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
            color: Themes.kGreyColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          children: [
            Image.asset(
              Images.cloudUpload,
              height: 42.0,
              width: 42.0,
            ),
            const SizedBox(height: 4.0),
            const Text(
              "Upload Photo",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Themes.kBlackColor,
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              color: Themes.kTransparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(1.5),
                onTap: () => Constants.showSnackBar(
                    context, "SUCCESS", "Picture Selected"),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Themes.kPrimaryColor,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                  child: Container(
                    height: 28.0,
                    width: 100.0,
                    alignment: Alignment.center,
                    child: const Text(
                      "Select File...",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Themes.kWhiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customButton(String title) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          if (title == "Submit") {
            Get.toNamed(Routes.RESTAURANT);
          } else {}
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
