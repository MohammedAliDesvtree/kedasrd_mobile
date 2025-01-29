import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_dropdown.dart';
import 'package:kedasrd/widgets/custom_search_bar.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/super_market/super_market_controller.dart';

class SuperMarketView extends StatefulWidget {
  const SuperMarketView({super.key});

  @override
  State<SuperMarketView> createState() => _SuperMarketViewState();
}

class _SuperMarketViewState extends State<SuperMarketView> {
  final GlobalKey<ScaffoldState> superMarketGlobalKey = GlobalKey();
  final SuperMarketController controller = Get.find<SuperMarketController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.of(context).size;

    controller.isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      key: superMarketGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      // bottomNavigationBar: controller.isKeyboardVisible
      //     ? const SizedBox.shrink()
      //     : SafeArea(child: buttonsView()),
      drawer: CustomDrawer(items: DummyData.superMarketDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                customHeader(),
                // const SizedBox(height: 16.0),
                isPortrait
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4.0),
                              child: const Text(
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
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(3, (index) {
                        return marketItemList(index);
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // if (!controller.isKeyboardVisible)
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
                    // bottomView(),
                    // const SizedBox(height: 16.0),
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
                        child: const Icon(
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
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: Column(
          children: [
            Container(
              width: Get.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Themes.kWhiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Themes.kBlackColor.withOpacity(0.20),
                    blurRadius: 8.0,
                    spreadRadius: -3,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                  const SizedBox(height: 12.0),
                  cartBullet("Barcode", "55487125"),
                  divider(),
                  cartBullet("Item Description", "Nachitos Ricos"),
                  divider(),
                  cartBullet("Price", "\$250.00"),
                  divider(),
                  cartBullet("Qty", "0"),
                  divider(),
                  cartBullet("Taxes", "\$38.14"),
                  divider(),
                  cartBullet("Disc %", "0"),
                  divider(),
                  cartBullet("Total", "\$538.14"),
                ],
              ),
            ),
          ],
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
            : title.contains("Qty")
                ? qtyView()
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

  Widget qtyView() {
    return Container(
      height: 26.0,
      width: 78.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(5.5),
          border: Border.all(width: 0.5, color: Themes.kGreyColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          qtyButton(Images.less),
          const Text(
            "2",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Themes.kBlackColor,
            ),
          ),
          qtyButton(Images.add),
        ],
      ),
    );
  }

  Widget qtyButton(String image) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(
        image,
        height: 11.0,
        width: 11.0,
        color: Themes.kPrimaryColor,
      ),
    );
  }

  Widget quantityView() {
    return Container(
      height: Get.width / 5,
      width: 32.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Themes.kPrimaryColor.withOpacity(0.3),
        // borderRadius: BorderRadius.circular(4.0),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(0.0),
          topLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              Images.less,
              height: 10.0,
              width: 10.0,
              color: Themes.kPrimaryColor,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5), // Start from below
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: const Text(
              "1",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              Images.add,
              height: 10.0,
              width: 10.0,
              color: Themes.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget closeButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(0.0),
          topLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor.withOpacity(0.3),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(0.0),
              topLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
            ),
          ),
          child: Container(
            height: 32.0,
            width: 32.0,
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              Images.delete,
              color: Themes.kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonsView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            List.generate(DummyData.superMarketButtonItems.length, (index) {
          var data = DummyData.superMarketButtonItems[index];
          return WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                duration: const Duration(milliseconds: 500),
                delay: Duration(milliseconds: index * 100)),
            child: Material(
              color: Themes.kTransparent,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  decoration: BoxDecoration(color: data["color"]),
                  child: Container(
                    height: 52.0,
                    width: 150.0,
                    alignment: Alignment.center,
                    child: Text(
                      data["title"].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Themes.kWhiteColor),
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

  Widget divider() {
    return Container(
      height: 0.2,
      width: Get.width,
      color: Themes.kGreyColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  Widget bottomView() {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
      child: Row(
        children: [
          Container(
            height: 52.0,
            width: Get.width / 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Themes.kPrimaryColor.withOpacity(0.5),
              ),
            ),
            child: const Text(
              "No. Items : ${0}",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Themes.kBlackColor,
              ),
            ),
          ),
          Container(
            height: 52.0,
            width: Get.width / 2,
            alignment: Alignment.center,
            color: Themes.kPrimaryColor.withOpacity(0.5),
            child: Text(
              "Payment : \$${0.00.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Themes.kBlackColor,
              ),
            ),
          ),
        ],
      ),
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
                // Text(
                //   "2 Item",
                //   style: TextStyle(
                //     fontSize: 14.0,
                //     fontWeight: FontWeight.w500,
                //     color: Themes.kGreyColor,
                //   ),
                // ),
                // SizedBox(width: 8.0),
                Text(
                  "3 Items",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Themes.kBlackColor,
                  ),
                ),
                // SizedBox(width: 8.0),
                // Text(
                //   "\$900",
                //   style: TextStyle(
                //     fontSize: 24.0,
                //     fontWeight: FontWeight.w600,
                //     color: Themes.kBlackColor,
                //   ),
                // ),
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
            // Row(
            //   children: [
            //     headerButton(Images.searchCustomer, "Customer"),
            //     const SizedBox(width: 10.0),
            //     headerButton(Images.searchItem, "Item"),
            //     const SizedBox(width: 10.0),
            //     headerButton(Images.currency, "Currency"),
            //   ],
            // ),
            Row(
              children: [
                WidgetAnimator(
                  atRestEffect: WidgetRestingEffects.swing(),
                  // key: ValueKey(cartController.cartItems.isNotEmpty),
                  // atRestEffect: cartController.cartItems.isNotEmpty
                  //     ? WidgetRestingEffects.swing()
                  //     : null,
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
                          color:
                              // cartController.cartItems.isNotEmpty
                              //     ? Themes.kRedColor
                              //     :
                              Themes.kRedColor,
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
                    )),
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

  // Widget headerButton(String icon, String type) {
  //   return GestureDetector(
  //     onTap: () => controller.searchCustomerToggle(type),
  //     child: Image.asset(
  //       icon,
  //       height: 22.0,
  //       color: Themes.kBlackColor,
  //     ),
  //   );
  // }
}
