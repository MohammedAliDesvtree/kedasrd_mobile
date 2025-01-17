import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';

import 'package:kedasrd/controllers/restaurant/restaurant_controller.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({super.key});

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  final GlobalKey<ScaffoldState> restaurantGlobalKey = GlobalKey();
  final RestaurantController controller = Get.find<RestaurantController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: restaurantGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "Restaurant",
                onMenuTapped: () =>
                    restaurantGlobalKey.currentState!.openDrawer()),
            WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(
                        delay: const Duration(milliseconds: 100)),
                child: customButton("New Order", Images.newOrder, size)),
            const SizedBox(height: 16.0),
            WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(
                        delay: const Duration(milliseconds: 200)),
                child: customButton("Active Order", Images.activeOrder, size)),
            const SizedBox(height: 16.0),
            WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(
                        delay: const Duration(milliseconds: 300)),
                child: customButton("Kitchen", Images.kitchen, size)),
          ],
        ),
      ),
    );
  }

  Widget customButton(String title, String image, Size size) {
    return GestureDetector(
      onTap: () {
        if (title.contains("New")) {
          Get.toNamed('/new_order');
        } else if (title.contains("Active")) {
          Get.toNamed('/active_order');
        } else {
          Get.toNamed('/kitchen');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Image.asset(
                image,
                height: 154.0,
                width: size.width,
                fit: BoxFit.fitWidth,
              ),
              Container(
                height: 154.0,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Themes.kTransparent,
                        Themes.kBlackColor.withOpacity(0.9)
                      ],
                      stops: const [
                        0.5,
                        1.0
                      ]),
                ),
              ),
              Positioned(
                left: 14.0,
                bottom: 14.0,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Themes.kWhiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
