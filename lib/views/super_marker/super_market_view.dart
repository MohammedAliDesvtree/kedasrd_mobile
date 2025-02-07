import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_dropdown.dart';
import 'package:kedasrd/widgets/custom_qty_view.dart';
import 'package:kedasrd/widgets/custom_search_bar.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/common_controller.dart';
import 'package:kedasrd/controllers/super_market/super_market_controller.dart';

class SuperMarketView extends StatefulWidget {
  const SuperMarketView({super.key});

  @override
  State<SuperMarketView> createState() => _SuperMarketViewState();
}

class _SuperMarketViewState extends State<SuperMarketView> {
  final GlobalKey<ScaffoldState> superMarketGlobalKey = GlobalKey();
  final SuperMarketController controller = Get.find<SuperMarketController>();
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: superMarketGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.superMarketDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                customHeader(),
                isPortrait
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, bottom: 4.0),
                              child: Text(
                                "Search by :",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Themes.kPrimaryColor,
                                ),
                              ),
                            ),
                            customTabList(size),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                isPortrait
                    ? Column(
                        children: [
                          const SizedBox(height: 16.0),
                          Obx(() =>
                              controller.selectedItems.contains("Customer")
                                  ? const Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0, right: 16.0),
                                          child: CustomSearchBar(
                                              isEnabled: true,
                                              title: "Search Customers"),
                                        ),
                                        SizedBox(height: 16.0),
                                      ],
                                    )
                                  : const SizedBox.shrink()),
                          Obx(() =>
                              controller.selectedItems.contains("Item Name")
                                  ? const Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0, right: 16.0),
                                          child: CustomSearchBar(
                                              isEnabled: true,
                                              title: "Search Item by Name"),
                                        ),
                                        SizedBox(height: 16.0),
                                      ],
                                    )
                                  : const SizedBox.shrink()),
                          Obx(() => controller.selectedItems
                                  .contains("Select Currency")
                              ? Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: CustomDropdowns(
                                          listData: DummyData.currencyItems,
                                          hintText: "Select Currency",
                                          borderRadius: 100.0,
                                          isShadow: true,
                                        )),
                                    const SizedBox(height: 16.0),
                                  ],
                                )
                              : const SizedBox.shrink()),
                        ],
                      )
                    : Row(
                        children: [
                          const SizedBox(width: 16.0),
                          const Expanded(
                            child: CustomSearchBar(
                                isEnabled: true, title: "Search Customers"),
                          ),
                          const SizedBox(width: 16.0),
                          const Expanded(
                            child: CustomSearchBar(
                                isEnabled: true, title: "Search Item by Name"),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: CustomDropdowns(
                              listData: DummyData.currencyItems,
                              hintText: "Select Currency",
                              borderRadius: 100.0,
                              isShadow: true,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                        ],
                      ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(3, (index) {
                        return marketItemList(index);
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: [
                    totalView(),
                    const SizedBox(height: 16.0),
                    Obx(() {
                      if (controller.isDigitsViewVisible.value) {
                        return Column(
                          children: [
                            digitsView(),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    })
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 24.0,
              child: WidgetAnimator(
                atRestEffect: WidgetRestingEffects.bounce(),
                child: Material(
                  color: Themes.kTransparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () => Constants.openBottomSheet(context,
                        "Super Market", DummyData.superMarketButtonItems),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Themes.kPrimaryColor,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: const SizedBox(
                        height: 44.0,
                        width: 44.0,
                        child: Icon(
                          Icons.menu,
                          size: 24.0,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget marketItemList(int index) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
          delay: Duration(milliseconds: index * 200)),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, bottom: 12.0, top: 4.0),
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Themes.kBlackColor.withOpacity(0.20),
                blurRadius: 8.0,
                spreadRadius: -3,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              // Title row with tap gesture
              GestureDetector(
                onTap: () => commonController.toggleItemExpansion(index),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        index % 2 == 1
                            ? "Salted Tahini Chocolate Chunk (1 ud)"
                            : "Nachitos Ricos",
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Themes.kBlackColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    CustomQtyView(
                      screenName: "SuperMarket",
                      initialValue: 2,
                      onDecrease: () {},
                      onIncrease: () {},
                    ),
                    const SizedBox(width: 16.0),
                    const Text(
                      "\$250.00",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Themes.kBlackColor,
                        height: 0.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () => Constants.showSnackBar(
                          context, "SUCCESS", "Item Removed!"),
                      child: Image.asset(
                        Images.delete,
                        height: 16.0,
                        width: 16.0,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Expandable section
              Obx(() => commonController.expandedIndex.value == index
                  ? Column(
                      children: [
                        const SizedBox(height: 12.0),
                        cartBullet("Barcode", "55487125"),
                        divider(),
                        cartBullet("Taxes", "\$38.14"),
                        divider(),
                        cartBullet("Disc %", "0"),
                        divider(),
                        cartBullet("Total", "\$538.14"),
                      ],
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartBullet(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: Themes.kPrimaryColor,
            height: 0.0,
          ),
        ),
        title.contains("Disc")
            ? inputView()
            : Text(
                value,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Themes.kBlackColor,
                  height: 0.0,
                ),
              ),
      ],
    );
  }

  Widget inputView() {
    return Container(
      height: 26.0,
      width: 32.0,
      padding: const EdgeInsets.only(bottom: 2.0),
      decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(5.5),
          border: Border.all(width: 0.5, color: Themes.kGreyColor)),
      child: TextFormField(
        cursorHeight: 12.0,
        style: const TextStyle(fontSize: 12.0, color: Themes.kBlackColor),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "0",
          hintStyle: TextStyle(
            fontSize: 12.0,
            color: Themes.kBlackColor,
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 0.2,
      width: Get.width,
      color: Themes.kGreyColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  Widget digitsView() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
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
      child: Column(
        children: [
          digitSection("Subtotal", 1500.00, 200),
          const SizedBox(height: 6.0),
          digitSection("Tax", 114.42, 400),
          const SizedBox(height: 6.0),
          digitSection("Discount", 0.00, 600),
          const SizedBox(height: 6.0),
          digitSection("Other Discount", 0.00, 800),
          const SizedBox(height: 6.0),
          digitSection("Tips Tax", 16.22, 1000),
          const SizedBox(height: 6.0),
          digitSection("Total Payment", 1630.64, 1200),
        ],
      ),
    );
  }

  Widget digitSection(String title, double amount, int delay) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
          delay: Duration(milliseconds: delay)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          digitText("$title :"),
          digitText("\$${amount.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget digitText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Themes.kBlackColor,
      ),
    );
  }

  Widget totalView() {
    return GestureDetector(
      onTap: () => controller.isDigitsViewVisible.value =
          !controller.isDigitsViewVisible.value,
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
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
            const Row(
              children: [
                Text(
                  "3 Items",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Themes.kBlackColor,
                  ),
                ),
              ],
            ),
            Image.asset(
              Images.downArrow,
              height: 18.0,
              width: 18.0,
              color: Themes.kPrimaryColor,
            )
          ],
        ),
      ),
    );
  }

  Widget customTabList(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(DummyData.superMarketItems.length, (index) {
          String title = DummyData.superMarketItems[index];
          return WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: index * 100),
            ),
            child: Obx(
              () => Material(
                color: Themes.kTransparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () => controller.toggleSelection(title),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Themes.kPrimaryColor.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: controller.selectedItems.contains(title)
                          ? Themes.kPrimaryColor.withOpacity(0.8)
                          : Themes.kTransparent,
                    ),
                    child: Container(
                      height: 40.0,
                      width: size.width / 3.4,
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.0,
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
          );
        }),
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
            const Padding(
              padding: EdgeInsets.only(left: 74.0),
              child: Text(
                "Super Market",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Themes.kBlackColor,
                ),
              ),
            ),
            Row(
              children: [
                WidgetAnimator(
                  atRestEffect: WidgetRestingEffects.swing(),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.SUPER_MARKET_CART),
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
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () => superMarketGlobalKey.currentState!.openDrawer(),
                  child: Image.asset(Images.menu, height: 22.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
