import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = HomeController();

  // @override
  // void initState() {
  //   super.initState();

  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //     SystemUiOverlay.top,
  //     SystemUiOverlay.bottom,
  //   ]);
  // }

  // @override
  // void dispose() {
  //   // Reset to default system UI overlay style
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
        // AnnotatedRegion<SystemUiOverlayStyle>(
        //   value: SystemUiOverlayStyle.dark.copyWith(
        //     statusBarColor: Themes.kWhiteColor,
        //     systemNavigationBarColor: Themes.kWhiteColor,
        //   ),
        //   child:
        Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            customHeader(),
            // const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      List.generate(DummyData.dashboardList.length, (index) {
                    var data = DummyData.dashboardList[index];
                    return WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromRight(
                              delay: Duration(milliseconds: index * 100)),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: GestureDetector(
                          onTap: () => controller.onItemTapped(data["title"]),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    data["icon"],
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
                                      "${data["title"]}",
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
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
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
