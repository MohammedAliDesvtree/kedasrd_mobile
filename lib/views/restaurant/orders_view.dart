import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';
import 'package:kedasrd/utils/constants.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            customHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: List.generate(DummyData.ordersItems.length, (index) {
                  var data = DummyData.ordersItems[index];

                  // Calculate item width based on orientation
                  final itemWidth = isPortrait
                      ? size.width - 32 // Account for padding
                      : (size.width / 2.2);

                  return WidgetAnimator(
                    incomingEffect:
                        WidgetTransitionEffects.incomingSlideInFromRight(
                            delay: Duration(milliseconds: index * 200)),
                    child: ordersItem(data, size, itemWidth),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ordersItem(dynamic data, Size size, double itemWidth) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.ALL_ORDERS, arguments: {"title": data["title"]}),
      child: Container(
        height: 52.0,
        width: itemWidth,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Themes.kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Themes.kBlackColor.withOpacity(0.20),
              blurRadius: 8.0,
              spreadRadius: -3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              data["icon"],
              width: 28.0,
              color: Themes.kPrimaryColor,
            ),
            Text(
              data["title"],
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Themes.kBlackColor,
              ),
            ),
          ],
        ),
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
                "Orders",
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
