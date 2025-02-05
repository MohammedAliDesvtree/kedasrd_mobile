import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_tabs_list.dart';
import 'package:kedasrd/widgets/custom_text_input.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
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
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: tablesGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment:
              isPortrait ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            CustomHeader(
                title: data["title"],
                onMenuTapped: () => tablesGlobalKey.currentState!.openDrawer()),
            CustomTabsList(data: DummyData.tableTabs, type: "Tables"),
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
              return tablesView(tableLength, isPortrait, size);
            }),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget tablesView(int tableLength, bool isPortrait, Size size) {
    return Obx(
      () => Expanded(
        child: SingleChildScrollView(
          key: ValueKey(controller.selectedTabIndex.value),
          padding: EdgeInsets.symmetric(horizontal: isPortrait ? 0.0 : 16.0),
          child: Wrap(
            runSpacing: 16.0,
            spacing: 16.0,
            children: List.generate(tableLength, (index) {
              // Calculate item width based on orientation
              final itemWidth = isPortrait
                  ? (size.width - 32) / 3.2 // Account for padding
                  : (size.width - 32) / 7.2;

              return WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingScaleDown(
                      delay: Duration(milliseconds: index * 100)),
                  child: customTables(index, controller.randomNumbers[index],
                      itemWidth, isPortrait, size));
            }),
          ),
        ),
      ),
    );
  }

  Widget customTables(int index, int randomNumber, double itemWidth,
      bool isPortrait, Size size) {
    return GestureDetector(
      onTap: () => Constants.openDialog(
        context: context,
        title: "Enter Code to\nContinue",
        btnText1: "Submit",
        scroll: const AlwaysScrollableScrollPhysics(),
        height: isPortrait ? size.height / 2.8 : 0,
        child: const CustomTextInput(hintText: "Enter Code", isNumber: true),
      ),
      child: Container(
        height: 92.0,
        width: itemWidth,
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
}
