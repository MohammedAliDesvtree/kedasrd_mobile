import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/controllers/restaurant/tables_controller.dart';

class CustomTabsList extends StatefulWidget {
  final dynamic data;
  final String type;
  const CustomTabsList({
    super.key,
    this.data,
    required this.type,
  });

  @override
  State<CustomTabsList> createState() => _CustomTabsListState();
}

class _CustomTabsListState extends State<CustomTabsList> {
  final TablesController controller = Get.find<TablesController>();

  @override
  void initState() {
    super.initState();
    // if (widget.type == "Tables") {
    controller.selectedTabIndex.value = 0;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List.generate(
        widget.data.length,
        (index) {
          var title = widget.data[index];
          return WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                delay: Duration(milliseconds: index * 200)),
            child: Material(
              color: Themes.kTransparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(48.0),
                onTap: () {
                  // if (widget.type == "Tables") {
                  controller.selectTab(index);
                  // }
                },
                child: Obx(
                  () {
                    final isSelected =
                        // widget.type == "Tables" &&
                        controller.selectedTabIndex.value == index;

                    return Ink(
                      decoration: BoxDecoration(
                          color: isSelected
                              ? Themes.kPrimaryColor // Selected color
                              : Themes.kWhiteColor, // Unselected color
                          border: Border.all(
                              width: 0.5, color: Themes.kPrimaryColor),
                          borderRadius: BorderRadius.circular(48.0)),
                      child: Container(
                        height: 42.0,
                        width: widget.type == "Tables" ? 108.0 : 78.0,
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Themes.kWhiteColor
                                : Themes.kGreyColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
