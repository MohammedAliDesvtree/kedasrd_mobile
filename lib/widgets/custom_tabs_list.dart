import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/controllers/restaurant/tables_controller.dart';

class CustomTabsList extends StatefulWidget {
  final dynamic listData;
  final String type;
  const CustomTabsList({
    super.key,
    this.listData,
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
    // Call onScreenEnter when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetTab();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.listData.length, (index) {
          var data = widget.listData[index];
          return WidgetAnimator(
            key: ValueKey(data["title"]),
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                delay: Duration(milliseconds: index * 200)),
            child: Column(
              children: [
                Material(
                  color: Themes.kTransparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(52.0),
                    onTap: () => controller.selectTab(index),
                    child: Obx(
                      () {
                        return Ink(
                          child: Container(
                            height: 48.0,
                            width: 48.0,
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              data["icon"],
                              height: 24.0,
                              width: 24.0,
                              color: controller.selectedTabIndex.value == index
                                  ? Themes.kPrimaryColor
                                  : Themes.kGreyColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 0.0),
                Obx(
                  () => Text(
                    data["title"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: controller.selectedTabIndex.value == index
                          ? Themes.kPrimaryColor
                          : Themes.kGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
