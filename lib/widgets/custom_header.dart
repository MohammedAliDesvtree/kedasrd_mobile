import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

class CustomHeader extends StatefulWidget {
  final String title;
  final dynamic onMenuTapped;
  const CustomHeader({super.key, required this.title, this.onMenuTapped});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    bool isSpecificTitle = (widget.title == "Regular" ||
        widget.title == "Restaurant" ||
        widget.title == "Cart" ||
        widget.title == "Kitchen" ||
        widget.title == "Active Orders" ||
        widget.title == "Active Tables" ||
        widget.title == "Tables" ||
        widget.title == "Active Order" ||
        widget.title == "New Order");
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: isSpecificTitle ? 32.0 : 0.0),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Themes.kBlackColor,
                  ),
                ),
              ),
            ),
            isSpecificTitle
                ? Row(
                    children: [
                      GestureDetector(
                          onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(Images.notification, height: 22.0),
                              Positioned(
                                top: -4.0,
                                right: -4.0,
                                child: Container(
                                  height: 16.0,
                                  width: 16.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Themes.kRedColor,
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: const Text(
                                    "2",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Themes.kWhiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(width: 12.0),
                      GestureDetector(
                          onTap: widget.onMenuTapped,
                          child: Image.asset(Images.menu, height: 22.0)),
                    ],
                  )
                : const SizedBox(width: 24.0)
          ],
        ),
      ),
    );
  }
}
