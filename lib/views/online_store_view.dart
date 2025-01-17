import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

import 'package:kedasrd/widgets/custom_loader.dart';
import 'package:kedasrd/widgets/custom_back_button.dart';

import 'package:kedasrd/controllers/online_store_controller.dart';

class OnlineStoreView extends StatefulWidget {
  const OnlineStoreView({super.key});

  @override
  State<OnlineStoreView> createState() => _OnlineStoreViewState();
}

class _OnlineStoreViewState extends State<OnlineStoreView> {
  OnlineStoreController controller = Get.put(OnlineStoreController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Themes.kTransparent,
        systemNavigationBarColor: Themes.kTransparent,
        systemNavigationBarDividerColor: Themes.kTransparent,
      ),
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: [
              if (!controller.isLoading.value)
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.storeBG),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Themes.kBlackColor.withOpacity(0.3),
                        Themes.kBlackColor.withOpacity(0.3)
                      ],
                      stops: const [
                        0.0,
                        1.0
                      ]),
                ),
              ),
              Positioned(
                top: 64.0,
                left: 16.0,
                right: 16.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomBackButton(),
                    Image.asset(
                      Images.kedasLogo,
                      height: 36.0,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 140.0,
                left: 0.0,
                right: 0.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 28.0),
                    Column(
                      children: [
                        WidgetAnimator(
                          incomingEffect:
                              WidgetTransitionEffects.incomingSlideInFromTop(),
                          child: Text(
                            "Order Here Please",
                            textAlign: TextAlign.center,
                            style: textStyle(),
                          ),
                        ),
                        const SizedBox(height: 28.0),
                        WidgetAnimator(
                          incomingEffect:
                              WidgetTransitionEffects.incomingSlideInFromTop(),
                          child: SizedBox(
                            width: Get.width / 1.9,
                            child: Text(
                              "Scan the QR code to order online now",
                              textAlign: TextAlign.center,
                              style: textStyle(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28.0),
                        AnimatedOpacity(
                          opacity: controller.isVisible.value ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                Images.qrCode,
                                height: 200.0,
                                width: 200.0,
                              ),
                              Image.asset(
                                Images.kedasLogo,
                                height: 36.0,
                                width: 84.0,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28.0),
                        WidgetAnimator(
                          incomingEffect: WidgetTransitionEffects
                              .incomingSlideInFromRight(),
                          child: SizedBox(
                            width: Get.width / 1.5,
                            child: Text(
                              "Or you can go to the website",
                              textAlign: TextAlign.center,
                              style: textStyle(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          height: 36.0,
                          color: Themes.kWhiteColor,
                          alignment: Alignment.center,
                          child: AnimatedTextKit(
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TypewriterAnimatedText(Constants.onlineStoreURL,
                                  textAlign: TextAlign.center,
                                  textStyle: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Themes.kPrimaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Themes.kPrimaryColor,
                                  ),
                                  speed: const Duration(milliseconds: 80))
                            ],
                            onTap: () => controller.openOnlineStore(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (controller.isLoading.value)
                const Center(
                  child: CustomLoader(),
                )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      color: Themes.kWhiteColor,
    );
  }
}
