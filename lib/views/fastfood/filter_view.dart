import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/pos/filter_controller.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  final FilterController controller = Get.find<FilterController>();

  @override
  void initState() {
    super.initState();
    controller.animatedFilterList();
  }

  @override
  void dispose() {
    super.dispose();
    controller.isVisibleItems =
        List.generate(DummyData.filterItems.length, (_) => false).obs;
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    double modalSize = isPortrait ? 0.9 : 0.75;

    return DraggableScrollableSheet(
      initialChildSize: modalSize, // Opens at 1/3 screen height
      minChildSize: modalSize, // Minimum 1/3 screen height
      maxChildSize: modalSize, // Maximum full screen height
      snap: false,
      // snapSizes: const [0.3, 0.6, 0.9],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.circular(28.0),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromTop(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
                  child: Text(
                    "Filter".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                ),
              ),
              closeButton(),
              filterList(size),
            ],
          ),
        );
      },
    );
  }

  Widget filterList(Size size) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 74.0, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Wrap(
              runSpacing: 8.0,
              spacing: 8.0,
              children: List.generate(DummyData.filterItems.length, (index) {
                var data = DummyData.filterItems[index];
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: controller.isVisibleItems[index] ? 1.0 : 0.0,
                  child: Material(
                    color: Themes.kTransparent,
                    child: InkWell(
                      onTap: () => controller.selectFilter(index),
                      borderRadius: BorderRadius.circular(4.0),
                      child: Ink(
                        height: 58.0,
                        width: size.width / 2.3,
                        decoration: BoxDecoration(
                            color: controller.selectedIndex.value == index
                                ? Themes.kPrimaryColor
                                : Themes.kPrimaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          alignment: Alignment.center,
                          child: Text(
                            data,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: controller.selectedIndex.value == index
                                  ? Themes.kWhiteColor
                                  : Themes.kBlackColor,
                            ),
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
      ),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(),
        child: Material(
          color: Themes.kTransparent,
          child: InkWell(
            onTap: () => Get.back(),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(28.0),
              bottomLeft: Radius.circular(28.0),
              topLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Themes.kPrimaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28.0),
                  bottomLeft: Radius.circular(28.0),
                  topLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: Container(
                height: 54.0,
                width: 54.0,
                padding: const EdgeInsets.all(21.0),
                child: Image.asset(
                  Images.close,
                  color: Themes.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
