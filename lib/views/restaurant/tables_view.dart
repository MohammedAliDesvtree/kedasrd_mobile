import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/custom_bottom_Sheet_Input.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/restaurant/tables_controller.dart';

class TablesView extends StatefulWidget {
  const TablesView({super.key});

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends State<TablesView> {
  dynamic data = Get.arguments;
  final GlobalKey<ScaffoldState> tablesGlobalKey = GlobalKey();
  final TablesController controller = Get.find<TablesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: tablesGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
                title: data["title"],
                onMenuTapped: () => tablesGlobalKey.currentState!.openDrawer()),
            tabList(),
            const SizedBox(height: 16.0),
            Obx(() {
              int tableLength = controller.selectedTabIndex.value == 0
                  ? 7
                  : controller.selectedTabIndex.value == 1
                      ? 2
                      : controller.selectedTabIndex.value == 2
                          ? 1
                          : controller.selectedTabIndex.value == 3
                              ? 1
                              : 1;
              return tablesView(tableLength);
            }),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget tablesView(int tableLength) {
    return Obx(
      () => Padding(
        key: ValueKey(controller.selectedTabIndex.value),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Wrap(
          runSpacing: 16.0,
          spacing: 16.0,
          children: List.generate(tableLength, (index) {
            return WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleDown(
                    delay: Duration(milliseconds: index * 100)),
                child: customTables(index, controller.randomNumbers[index]));
          }),
        ),
      ),
    );
  }

  Widget customTables(int index, int randomNumber) {
    return GestureDetector(
      onTap: () => continueTable(),
      child: Container(
        height: 92.0,
        width: Get.width / 3.6,
        decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Themes.kBlackColor.withOpacity(0.20),
              blurRadius: 8.0,
              spreadRadius: -3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          // alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 5.0,
              left: 0.0,
              right: 0.0,
              child: Image.asset(
                Images.table,
                height: 50.0,
                width: 50.0,
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: 0.0,
              right: 0.0,
              child: Text(
                "Table ${index + 1}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Themes.kBlackColor,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Container(
                height: 19.0,
                width: 38.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: data["title"] == "Tables"
                        ? (randomNumber % 3 == 1
                            ? Themes.kGreenColor
                            : Themes.kRedColor)
                        : Themes.kPrimaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10.0))),
                child: Text(
                  "$randomNumber",
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Themes.kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(DummyData.tableTabs.length, (index) {
          String title = DummyData.tableTabs[index];
          return WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                delay: Duration(milliseconds: index * 200)),
            child: Padding(
              padding:
                  EdgeInsets.only(left: index == 0 ? 12.0 : 0.0, right: 12.0),
              child: Material(
                color: Themes.kTransparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(48.0),
                  onTap: () => controller.selectTab(index),
                  child: Obx(
                    () => Ink(
                      decoration: BoxDecoration(
                          color: controller.selectedTabIndex.value == index
                              ? Themes.kPrimaryColor // Selected color
                              : Themes.kWhiteColor, // Unselected color
                          border: Border.all(
                              width: 0.5, color: Themes.kPrimaryColor),
                          borderRadius: BorderRadius.circular(48.0)),
                      child: Container(
                        height: 42.0,
                        width: 136.0,
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: controller.selectedTabIndex.value == index
                                ? Themes.kWhiteColor
                                : Themes.kGreyColor,
                          ),
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
    );
  }

  dynamic continueTable() {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) => const CustomBottomSheetInput(
        title: "Enter Code to Continue",
        hintText: "Enter Code",
        btnText1: "Submit",
      ),
    );
  }
}