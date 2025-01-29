import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/restaurant/kitchen_controller.dart';

class KitchenView extends StatefulWidget {
  const KitchenView({super.key});

  @override
  State<KitchenView> createState() => _KitchenViewState();
}

class _KitchenViewState extends State<KitchenView> {
  final GlobalKey<ScaffoldState> kitchenGlobalKey = GlobalKey();
  final KitchenController controller = Get.find<KitchenController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: kitchenGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "Kitchen",
                onMenuTapped: () =>
                    kitchenGlobalKey.currentState!.openDrawer()),
            const SizedBox(height: 16.0),
            totalCountView(),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: List.generate(8, (index) {
                    // Calculate item width based on orientation
                    final itemWidth = isPortrait
                        ? size.width - 32 // Account for padding
                        : (size.width / 2.2);

                    return WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromRight(
                              delay: Duration(milliseconds: index * 500)),
                      child:
                          orderView(controller.orders[index], index, itemWidth),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 28.0),
          ],
        ),
      ),
    );
  }

  Widget totalCountView() {
    return Container(
      height: 44.0,
      // width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Themes.kPrimaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0)),
      child: const Text(
        "Total Order : 10",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Themes.kPrimaryColor,
        ),
      ),
    );
  }

  Widget orderView(List<String> items, int index, double itemWidth) {
    return Container(
      width: itemWidth,
      // margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
          color: Themes.kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 24.0,
            right: -6.0,
            child: GestureDetector(
              onTap: () =>
                  Constants.showSnackBar(context, "SUCCESS", "Printing..."),
              child: Image.asset(
                Images.printer,
                height: 22.0,
                width: 22.0,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
          Positioned(
            top: -12.0,
            right: -12.0,
            child: Container(
              height: 28.0,
              width: 84.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Themes.kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              child: Text(
                index % 2 != 0 ? "Table: 8" : "Delivery",
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Themes.kWhiteColor,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              keyValuesBullet("Order Id : ", "139925"),
              const SizedBox(height: 4.0),
              keyValuesBullet("Customer : ", "Paloma Medrano"),
              const SizedBox(height: 12.0),
              Column(
                children: List.generate(items.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: items.length - 1 == index ? 0.0 : 8.0),
                    child:
                        //  WidgetAnimator(
                        //   incomingEffect:
                        //       WidgetTransitionEffects.incomingSlideInFromRight(
                        //           delay: Duration(milliseconds: index * 500)),
                        //   child:
                        singleOrderView(index),
                    // ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget singleOrderView(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Themes.kPrimaryColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Qty : 2",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                  Text(
                    "20:55",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                "Chicharroncitos De Pollo",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Themes.kWhiteColor,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -6.0,
            right: -6.0,
            child: Material(
              color: Themes.kTransparent,
              child: InkWell(
                onTap: () {
                  if (index % 2 != 0) {
                    Constants.showSnackBar(
                        context, "SUCCESS", "Status Changes Successfully!");
                  }
                },
                borderRadius: BorderRadius.circular(100),
                child: Ink(
                  decoration: BoxDecoration(
                    color: index % 2 != 0
                        ? Themes.kRedColor
                        : index % 3 != 0
                            ? Themes.kGreenColor
                            : Themes.kOrangeColor,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Container(
                    height: 19.0,
                    width: 84.0,
                    alignment: Alignment.center,
                    child: Text(
                      index % 2 != 0
                          ? "Start"
                          : index % 3 != 0
                              ? "Done"
                              : "In Progress",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Themes.kWhiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget keyValuesBullet(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Themes.kPrimaryColor,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Themes.kBlackColor,
          ),
        ),
      ],
    );
  }
}
