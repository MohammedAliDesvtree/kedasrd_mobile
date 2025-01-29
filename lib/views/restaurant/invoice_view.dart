import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

class InvoiceView extends StatelessWidget {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            customHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    customView(
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Printed by"),
                              customText("Value", "Elvis Rodriguez"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Date & Time"),
                              customText("Value", "28/01/2025, 05:25 PM"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Table No"),
                              customText("Value", "#4"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    customView(
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Items"),
                              customText("Key", "QTY"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Value", "Margerita Pizza"),
                              customText("Value", "2"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Value", "Peri Peri French Fries"),
                              customText("Value", "1"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Value", "Coca Cola"),
                              customText("Value", "2"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Value", "Cheese Ball"),
                              customText("Value", "2"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    customView(
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Sub Total"),
                              customText("Value", "\$847.46"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Tax"),
                              customText("Value", "\$152.00"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Tips"),
                              customText("Value", "\$24.00"),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Discount"),
                              customText("Value", "\$50.00"),
                            ],
                          ),
                          Container(
                            height: 1,
                            width: size.width,
                            color: Themes.kBlackColor,
                            margin: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Ex", "Total"),
                              customText("Ex", "\$700.00"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    customView(
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText("Key", "Payment mode"),
                              customText("Value", "Debit Card"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customView(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Themes.kGreyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }

  Widget customText(String type, String txt) {
    return Text(
      ((type == "Key" && txt == "QTY") || txt.contains("\$"))
          ? txt
          : (type == "Key" || type == "Ex")
              ? "$txt :"
              : txt,
      style: TextStyle(
        fontSize: type == "Key"
            ? 15.0
            : type == "Ex"
                ? 16.0
                : 14.0,
        fontWeight: type == "Key"
            ? FontWeight.w600
            : type == "Ex"
                ? FontWeight.w800
                : FontWeight.w400,
        color: type == "Key" ? Themes.kPrimaryColor : Themes.kBlackColor,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset(
                Images.leftArrow,
                height: 22.0,
                color: Themes.kBlackColor,
              ),
            ),
            const Text(
              "Kitchen Order",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Themes.kBlackColor,
              ),
            ),
            const SizedBox(width: 22.0),
          ],
        ),
      ),
    );
  }
}
