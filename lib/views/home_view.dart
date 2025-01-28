import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/wrap_list.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/common_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            customHeader(),
            WrapList(
                listData: DummyData.dashboardList,
                onItemTap: (title) => commonController.onHomeItemTapped(
                    context, size, isPortrait, title)),
          ],
        ),
      ),
      // ),
    );
  }

  Widget customHeader() {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(),
      child: Container(
        height: Constants.headerHeight,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(Images.kedasPos, height: 20.0),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTap: () => Get.toNamed('/notifications'),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(Images.notification, height: 22.0),
                  Positioned(
                    top: -4.0,
                    right: -4.0,
                    child: Container(
                      height: 16.0,
                      width: 16.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Themes.kRedColor,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: const Text(
                        "2",
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
