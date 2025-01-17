import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/dummy_data.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';

class NewOrderView extends StatefulWidget {
  const NewOrderView({super.key});

  @override
  State<NewOrderView> createState() => _NewOrderViewState();
}

class _NewOrderViewState extends State<NewOrderView> {
  final GlobalKey<ScaffoldState> newOrderGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: newOrderGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "New Order",
                onMenuTapped: () =>
                    newOrderGlobalKey.currentState!.openDrawer()),
            WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(
                        delay: const Duration(milliseconds: 100)),
                child: customButton("Dine In", Images.dineIn, size)),
            const SizedBox(height: 16.0),
            WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(
                        delay: const Duration(milliseconds: 200)),
                child: customButton("Delivery", Images.delivery, size)),
            const SizedBox(height: 16.0),
            WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(
                        delay: const Duration(milliseconds: 300)),
                child: customButton("Pickup", Images.pickUp, size)),
          ],
        ),
      ),
    );
  }

  Widget customButton(String title, String image, Size size) {
    return GestureDetector(
      onTap: () {
        if (title.contains("Dine")) {
          Get.toNamed('/tables', arguments: {"title": "Tables"});
        } else {
          Get.toNamed('/fastFood', arguments: {"title": "Delivery"});
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
