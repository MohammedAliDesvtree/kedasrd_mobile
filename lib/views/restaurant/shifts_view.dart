import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd/widgets/custom_bottom_sheet_shifts.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

import 'package:kedasrd/controllers/restaurant/shifts_controller.dart';

class ShiftsView extends StatefulWidget {
  const ShiftsView({super.key});

  @override
  State<ShiftsView> createState() => _ShiftsViewState();
}

class _ShiftsViewState extends State<ShiftsView> {
  final ShiftsController controller = Get.put(ShiftsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            customHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: List.generate(7, (index) {
                      return WidgetAnimator(
                        key: Key('shift_item_$index'),
                        incomingEffect:
                            WidgetTransitionEffects.incomingSlideInFromRight(
                                delay: Duration(milliseconds: index * 200)),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14.0),
                          child: shiftItem(size, index),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget shiftItem(Size size, int index) {
    return Obx(() {
      bool isExpanded = controller.isExpanded[index] ?? false;
      return GestureDetector(
        onTap: () => controller.toggleExpansion(index),
        child: Container(
          // height: 56.0,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Themes.kBlackColor.withOpacity(0.20),
                blurRadius: 8.0,
                spreadRadius: -3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Click on Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      itemBullet("Closure No ${index + 1}", 14.0,
                          FontWeight.w500, Themes.kPrimaryColor),
                      itemBullet("02/11/2022 01:51 AM", 14.0, FontWeight.w500,
                          Themes.kBlackColor),
                    ],
                  ),
                  Image.asset(
                    Images.downArrow,
                    width: 15.0,
                    color: Themes.kPrimaryColor,
                  ),
                ],
              ),

              // Hide View
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Column(
                        children: [
                          const SizedBox(height: 14.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  itemBullet("Start Date", 10.0,
                                      FontWeight.w400, Themes.kPrimaryColor),
                                  itemBullet("02/11/2022", 10.0,
                                      FontWeight.w600, Themes.kBlackColor),
                                ],
                              ),
                              Column(
                                children: [
                                  itemBullet("Initial Base", 10.0,
                                      FontWeight.w400, Themes.kPrimaryColor),
                                  itemBullet("DOP \$0.00", 10.0,
                                      FontWeight.w600, Themes.kBlackColor),
                                ],
                              ),
                              Column(
                                children: [
                                  itemBullet("Incomes", 10.0, FontWeight.w400,
                                      Themes.kPrimaryColor),
                                  itemBullet("DOP \$0.00", 10.0,
                                      FontWeight.w600, Themes.kBlackColor),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              itemBullet("Initial Base", 14.0, FontWeight.w500,
                                  Themes.kPrimaryColor),
                              itemBullet("DOP \$0.00", 14.0, FontWeight.w500,
                                  Themes.kBlackColor),
                            ],
                          ),
                          Container(
                            height: 0.5,
                            width: Get.width,
                            color: Themes.kGreyColor,
                            margin: const EdgeInsets.symmetric(vertical: 6.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              itemBullet("Total", 14.0, FontWeight.w500,
                                  Themes.kPrimaryColor),
                              itemBullet("DOP \$0.00", 14.0, FontWeight.w500,
                                  Themes.kBlackColor),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customButton("Print", Images.printer),
                              if (index == 0)
                                Row(
                                  children: [
                                    const SizedBox(width: 8.0),
                                    customButton(
                                        "Close Shift", Images.closeOutlined),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    });
  }

  dynamic closeShift(context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) => const CustomBottomSheetShifts(
        title: "Close Shift",
        hintText: "Observations",
        btnText1: "Submit",
        btnText2: "Close and Print",
      ),
    );
  }

  Widget customButton(String title, String icon) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: () {
          if (title == "Print") {
            Constants.showSnackBar(context, "Printing...");
          } else {
            closeShift(context);
          }
        },
        child: Ink(
          decoration: BoxDecoration(
              color: title == "Print" ? Themes.kPrimaryColor : Themes.kRedColor,
              borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  height: 16.0,
                  color: Themes.kWhiteColor,
                ),
                const SizedBox(width: 6.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Themes.kWhiteColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemBullet(
    String title,
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
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
            const Expanded(
              child: Text(
                "Shifts",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Themes.kBlackColor,
                ),
              ),
            ),
            const SizedBox(width: 20.0),
          ],
        ),
      ),
    );
  }
}
