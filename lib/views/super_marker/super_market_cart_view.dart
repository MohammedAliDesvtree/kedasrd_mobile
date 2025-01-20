import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/controllers/super_market/super_market_cart_controller.dart';

class SuperMarketCartView extends StatefulWidget {
  const SuperMarketCartView({super.key});

  @override
  State<SuperMarketCartView> createState() => _SuperMarketCartViewState();
}

class _SuperMarketCartViewState extends State<SuperMarketCartView> {
  final SuperMarketCartController controller =
      Get.put(SuperMarketCartController());

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      bottomNavigationBar: SizedBox(
        height: size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            deskTabList(),
            SafeArea(child: keyboardView(isPortrait, size)),
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const CustomHeader(title: "Super Market"),
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                  delay: const Duration(milliseconds: 500)),
              child: Text(
                "Total Bill \$${0.00.toStringAsFixed(2)}".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Themes.kBlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget keyboardView(bool isPortrait, Size size) {
    return Wrap(
      spacing: 1.0,
      runSpacing: 1.0,
      children: List.generate(11, (index) {
        final itemWidth = isPortrait
            ? (index == 10 ? size.width / 1.51 : size.width / 3.03)
            : (index == 10 ? size.width : size.width / 5.03);

        return WidgetAnimator(
          incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
              delay: Duration(milliseconds: index * 100)),
          child: Material(
            color: Themes.kTransparent,
            child: InkWell(
              onTap: () {},
              child: Ink(
                color: Themes.kPrimaryColor.withOpacity(0.8),
                child: Container(
                  height: 52.0,
                  width: itemWidth,
                  alignment: Alignment.center,
                  child: Text(
                    index == 10 ? "Delete" : "${index + 1}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget deskTabList() {
    return Wrap(
      spacing: 1.0,
      runSpacing: 1.0,
      children:
          List.generate(DummyData.superMarketCartDeskItems.length, (index) {
        String title = DummyData.superMarketCartDeskItems[index];
        return WidgetAnimator(
          incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
              delay: Duration(milliseconds: index * 100)),
          child: Material(
            color: Themes.kTransparent,
            child: InkWell(
              onTap: () => controller.onTappedSpecificView(title, context),
              child: Ink(
                color: Themes.kGreenColor.withOpacity(0.8),
                child: Container(
                  height: 52.0,
                  width: Get.width / 3.03,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
