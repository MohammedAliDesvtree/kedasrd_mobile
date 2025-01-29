import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/widgets/product_info.dart';
import 'package:kedasrd/widgets/custom_search_bar.dart';

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
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                customHeader(),
                tabList(),
                const SizedBox(height: 16.0),
                Obx(() => controller.isSearchVisible.value
                    ? const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            child: CustomSearchBar(
                                isEnabled: true, title: "Search Item by Name"),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      )
                    : const SizedBox.shrink()),
                productList(isPortrait, size),
                const SizedBox(height: 24.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget viewCartButton() {
    return Positioned(
      bottom: 8.0,
      left: 0.0,
      right: 0.0,
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
        child: Container(
          height: 67.0,
          margin: const EdgeInsets.only(bottom: 24.0, left: 32.0, right: 32.0),
          padding: const EdgeInsets.only(left: 24.0, right: 8.0),
          decoration: BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.circular(12.0),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1 Item",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Themes.kGreyColor,
                    ),
                  ),
                  Text(
                    "DOP \$847.46",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Themes.kBlackColor,
                    ),
                  ),
                ],
              ),
              Material(
                color: Themes.kTransparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: () => Get.toNamed(Routes.FAST_FOOD_CART,
                      arguments: {"title": "Online Store"}),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Themes.kPrimaryColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      height: 50.0,
                      width: 160.0,
                      alignment: Alignment.center,
                      child: const Text(
                        "View Cart",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productList(bool isPortrait, Size size) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: List.generate(
              DummyData.productList.length,
              (index) {
                var data = DummyData.productList[index];

                // Calculate item width based on orientation
                final itemWidth = isPortrait
                    ? size.width - 32 // Account for padding
                    : (size.width / 2.2);

                return WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromRight(
                          delay: Duration(milliseconds: index * 150)),
                  child: Container(
                    height: 84.0,
                    width: itemWidth,
                    decoration: BoxDecoration(
                      color: Themes.kWhiteColor,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Themes.kBlackColor.withOpacity(0.25),
                          blurRadius: 8.0,
                          spreadRadius: -3,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 116.0,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: -74.0,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(100.0),
                                            bottomRight:
                                                Radius.circular(100.0)),
                                        child: Image.asset(
                                          data["image"],
                                          height: 124.0,
                                          width: 168.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data["title"],
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      color: Themes.kBlackColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${data["price"]}",
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700,
                                      color: Themes.kBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: Material(
                              color: Themes.kTransparent,
                              child: InkWell(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(13.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  isDismissible: false,
                                  enableDrag: false,
                                  isScrollControlled:
                                      true, // To allow full screen dragging
                                  backgroundColor: Themes.kTransparent,
                                  builder: (context) {
                                    return ProductInfo(
                                        itemData: data, index: index);
                                  },
                                ),
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    color: Themes.kPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(13.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          Images.add,
                                          height: 10.0,
                                          width: 10.0,
                                          color: Themes.kWhiteColor,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          "Add".toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w700,
                                            color: Themes.kWhiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget tabList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(DummyData.filterItems.length, (index) {
          String title = DummyData.filterItems[index];
          return WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                delay: Duration(milliseconds: index * 200)),
            child: Padding(
              padding:
                  EdgeInsets.only(left: index == 0 ? 12.0 : 0.0, right: 12.0),
              child: Material(
                color: Themes.kTransparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(48.0),
                  onTap: () => controller.selectTab(index),
                  child: Obx(
                    () => Ink(
                      decoration: BoxDecoration(
                          color: controller.selectedTabIndex.value == index
                              ? Themes.kPrimaryColor // Selected color
                              : Themes.kWhiteColor, // Unselected color
                          border: Border.all(
                              width: 0.5, color: Themes.kPrimaryColor),
                          borderRadius: BorderRadius.circular(48.0)),
                      child: Container(
                        height: 42.0,
                        width: 136.0,
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: controller.selectedTabIndex.value == index
                                ? Themes.kWhiteColor
                                : Themes.kGreyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget customTabList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(DummyData.superMarketItems.length, (index) {
            String title = DummyData.superMarketItems[index];
            return WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                duration: const Duration(milliseconds: 500),
                delay: Duration(milliseconds: index * 100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Obx(
                  () => Material(
                    color: Themes.kTransparent,
                    child: InkWell(
                      onTap: () => controller.toggleSelection(title),
                      child: Ink(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Themes.kPrimaryColor.withOpacity(0.5),
                          ),
                          color: controller.selectedItems.contains(title)
                              ? Themes.kPrimaryColor.withOpacity(0.8)
                              : Themes.kTransparent,
                        ),
                        child: Container(
                          height: 42.0,
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          alignment: Alignment.center,
                          child: Text(
                            title.contains("Customer") ? "Price List" : title,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: controller.selectedItems.contains(title)
                                  ? Themes.kWhiteColor
                                  : Themes.kBlackColor,
                            ),
                          ),
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
    );
  }

  Widget customHeader() {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(),
      child: Container(
        height: Constants.headerHeight,
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: Padding(
                padding: EdgeInsets.only(left: 68.0),
                child: Text(
                  "Online Store",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Themes.kBlackColor,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => controller.isSearchVisible.value =
                      !controller.isSearchVisible.value,
                  child: Image.asset(
                    Images.search,
                    height: 24.0,
                    color: Themes.kBlackColor,
                  ),
                ),
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.FAST_FOOD_CART,
                      arguments: {"title": "Online Store"}),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      const Positioned(
                        top: -14.0,
                        left: 6.0,
                        right: 0.0,
                        child: Text(
                          "3",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Themes.kRedColor,
                            height: 0.0,
                          ),
                        ),
                      ),
                      Image.asset(
                        Images.shoppingCart,
                        height: 20.0,
                        color: Themes.kRedColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
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
          ],
        ),
      ),
    );
  }
}
