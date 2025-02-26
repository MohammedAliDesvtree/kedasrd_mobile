import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_dialog.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({super.key});

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  final GlobalKey<ScaffoldState> deliveryGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: deliveryGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "Active Orders",
                onMenuTapped: () =>
                    deliveryGlobalKey.currentState!.openDrawer()),
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
                          WidgetTransitionEffects.incomingSlideInFromBottom(
                              delay: Duration(milliseconds: index * 100)),
                      child: customButton(index, itemWidth),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget customButton(int index, double itemWidth) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.FAST_FOOD_CART, arguments: {"title": "Delivery"}),
      child: Container(
        height: 56.0,
        width: itemWidth,
        padding: const EdgeInsets.only(left: 10.0),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Order Id : ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                    Text(
                      "140844",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Themes.kBlackColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Customer : ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                    Text(
                      "Paloma Medrano",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Themes.kBlackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Material(
                  color: Themes.kTransparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28.0),
                    onTap: () => deleteOrder(context),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Themes.kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(28.0)),
                      child: Container(
                        height: 24.0,
                        width: 24.0,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28.0)),
                        child: Image.asset(Images.close,
                            color: Themes.kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  dynamic deleteOrder(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomDialog(
            title: "Delete Order",
            msg: "Are you sure or want to delete order ?",
            positiveAction: () {
              Constants.showSnackBar(context, "SUCCESS", "Order Deleted!");
              Get.back();
            }));
  }
}
