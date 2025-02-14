import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_tabs_list.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/restaurant/dine_in_controller.dart';

class DineInOrderView extends StatefulWidget {
  const DineInOrderView({super.key});

  @override
  State<DineInOrderView> createState() => _DineInOrderViewState();
}

class _DineInOrderViewState extends State<DineInOrderView> {
  final GlobalKey<ScaffoldState> dineInOrderGlobalKey = GlobalKey();
  final DineInController controller = Get.find<DineInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: dineInOrderGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "Active Tables",
                onMenuTapped: () =>
                    dineInOrderGlobalKey.currentState!.openDrawer()),
            CustomTabsList(listData: DummyData.tableTabs, type: "Tables"),
            const SizedBox(height: 16.0),
            Obx(
              () => controller.selectedTabIndex.value == 0
                  ? activeTables(4)
                  : controller.selectedTabIndex.value == 2
                      ? activeTables(12)
                      : controller.selectedTabIndex.value == 4
                          ? activeTables(8)
                          : Expanded(
                              child: Container(
                                height: Get.height,
                                alignment: Alignment.center,
                                child: const Text(
                                  "No data found!",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Themes.kBlackColor,
                                  ),
                                ),
                              ),
                            ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget activeTables(int tableLength) {
    return Expanded(
      child: Wrap(
        runSpacing: 16.0,
        spacing: 16.0,
        children: List.generate(tableLength, (index) {
          return WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                delay: Duration(milliseconds: index * 100)),
            child: customButton(),
          );
        }),
      ),
    );
  }

  Widget customButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        onTap: () {},
        child: Ink(
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
          child: Container(
            height: 80.0,
            width: Get.width / 2.3,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Images.table,
                  height: 25.0,
                  width: 34.0,
                ),
                Text(
                  "Mesa Lateral - 56".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Themes.kBlackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
