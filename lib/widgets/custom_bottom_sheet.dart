import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

import 'package:kedasrd/controllers/custom_bottom_sheet_controller.dart';

class CustomBottomSheet extends StatefulWidget {
  final String title;
  final List<dynamic> listData;
  const CustomBottomSheet(
      {super.key, required this.title, required this.listData});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final CustomBottomSheetController controller =
      Get.put(CustomBottomSheetController());

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    double modalSize = !isPortrait
        ? 0.6
        : widget.title.contains("Payment")
            ? 0.4
            : widget.title == "Super Market"
                ? 0.34
                : widget.title.contains("Item")
                    ? 0.25
                    : 0.2;
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
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
                  child: Text(
                    widget.title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                ),
              ),
              closeButton(),
              filterList(size),
            ],
          ),
        );
      },
    );
  }

  Widget filterList(Size size) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            top: 74.0,
            left: widget.title == "Super Market" ? 0 : 16.0,
            right: widget.title == "Super Market" ? 0 : 16.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Wrap(
              runSpacing: widget.title == "Super Market" ? 0.0 : 16.0,
              spacing: widget.title == "Super Market" ? 0.0 : 16.0,
              children: List.generate(widget.listData.length, (index) {
                var data = widget.listData[index];
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: controller.isVisibleItems[index] ? 1.0 : 0.0,
                  child: Material(
                    color: Themes.kTransparent,
                    child: InkWell(
                      onTap: () {
                        if (widget.title == "Export") {
                          Constants.showSnackBar(
                              context, "SUCCESS", "Exporting...");
                          controller.selectFilter(index);
                        } else if (widget.title == "Share") {
                          Constants.showSnackBar(
                              context, "SUCCESS", "Sharing...");
                          controller.selectFilter(index);
                        } else if (widget.title.contains("Payment")) {
                          Get.back();
                          controller.onTappedSpecificView(data, context);
                        } else if (widget.title == "Super Market") {
                          controller.onTabTapped(data["title"], context);
                        } else {
                          controller.selectFilter(index);
                        }
                      },
                      borderRadius: BorderRadius.circular(
                          widget.title == "Super Market" ? 0.0 : 4.0),
                      child: IntrinsicWidth(
                        child: Ink(
                          height: widget.title == "Super Market" ? 64.0 : null,
                          width: widget.title == "Super Market"
                              ? size.width / 2.2
                              : null,
                          decoration: BoxDecoration(
                              color: widget.title == "Super Market"
                                  ? data["color"]
                                  : controller.selectedIndex.value == index
                                      ? Themes.kPrimaryColor
                                      : Themes.kPrimaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  widget.title == "Super Market" ? 0.0 : 4.0)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            alignment: Alignment.center,
                            child: Text(
                              widget.title == "Super Market"
                                  ? data["title"].toUpperCase()
                                  : data,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: widget.title == "Super Market"
                                    ? 16.0
                                    : 14.0,
                                fontWeight: FontWeight.w600,
                                color:
                                    (controller.selectedIndex.value == index ||
                                            widget.title == "Super Market")
                                        ? Themes.kWhiteColor
                                        : Themes.kBlackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
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
}
