import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_dialog.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/pos/cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final GlobalKey<ScaffoldState> cartGlobalKey = GlobalKey();
  final CartController controller = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    controller.calculateTotals();
    ever(controller.cartItems, (_) => controller.calculateTotals());
  }

  @override
  Widget build(BuildContext context) {
    controller.isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    // if (controller.isKeyboardVisible) {
    //   controller.isDigitsViewVisible.value = false;
    // }
    return GestureDetector(
      onTap: () => controller.isDiscountFieldVisible.value = false,
      child: Scaffold(
        key: cartGlobalKey,
        backgroundColor: Themes.kWhiteColor,
        drawer: CustomDrawer(items: DummyData.posDrawerItems),
        bottomNavigationBar: bottomButtons(),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomHeader(
                  title: "Cart",
                  onMenuTapped: () => cartGlobalKey.currentState!.openDrawer()),
              searchBar(),
              const SizedBox(height: 16.0),
              Obx(() => controller.cartItems.isEmpty
                  ? emptySection()
                  : cartItemsSection()),
              // if (!controller.isKeyboardVisible)
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
        ),
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
            Row(
              children: [
                Obx(
                  () => Text(
                    "${controller.cartItems.length} Items",
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kBlackColor,
                    ),
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

  Widget cartItemsSection() {
    return Expanded(
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: List.generate(controller.cartItems.length, (index) {
              var data = controller.cartItems[index];
              return AnimatedOpacity(
                opacity: data.isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: WidgetAnimator(
                  key: ValueKey(data.hashCode),
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromRight(
                    duration: const Duration(milliseconds: 400),
                    delay: Duration(milliseconds: 150 * index),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.name,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    "DOP \$${(data.price.value * data.quantity.value - (controller.discountPercentage.value / 100)).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width / 4.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // GestureDetector(
                                      //   onTap: () => controller.updateQuantity(
                                      //       index, false),
                                      //   child: Image.asset(
                                      //     Images.less,
                                      //     height: 10.0,
                                      //     width: 10.0,
                                      //   ),
                                      // ),
                                      qtyButton(Images.less, "Decrease", index),
                                      Obx(
                                        () => AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          transitionBuilder: (Widget child,
                                              Animation<double> animation) {
                                            return SlideTransition(
                                              position: Tween<Offset>(
                                                begin: const Offset(
                                                    0, 0.5), // Start from below
                                                end: Offset.zero,
                                              ).animate(animation),
                                              child: child,
                                            );
                                          },
                                          child: Text(
                                            key: ValueKey<int>(
                                                data.quantity.value),
                                            "${data.quantity}",
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Themes.kBlackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      qtyButton(Images.add, "Increase", index),
                                      // GestureDetector(
                                      //   onTap: () => controller.updateQuantity(
                                      //       index, true),
                                      //   child: Image.asset(
                                      //     Images.add,
                                      //     height: 10.0,
                                      //     width: 10.0,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => controller.deleteItem(index),
                                  child: Image.asset(
                                    Images.delete,
                                    height: 17.0,
                                    width: 17.0,
                                    color: Themes.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget qtyButton(String image, String type, int index) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(7.0),
        onTap: () {
          if (type == "Decrease") {
            controller.updateQuantity(index, false);
          } else {
            controller.updateQuantity(index, true);
          }
        },
        child: Ink(
          decoration: BoxDecoration(
              color: Themes.kPrimaryColor,
              borderRadius: BorderRadius.circular(7.0)),
          child: Container(
            height: 25.0,
            width: 26.0,
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(image, color: Themes.kWhiteColor),
          ),
        ),
      ),
    );
  }

  Widget emptySection() {
    return Expanded(
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.bounce(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Empty Cart",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: Themes.kPrimaryColor,
              ),
            ),
            const SizedBox(width: 8.0),
            Image.asset(
              Images.sadFace,
              height: 28.0,
              width: 28.0,
              color: Themes.kPrimaryColor,
            ),
          ],
        ),
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
      child: Obx(
        () => Column(
          children: [
            digitSection("Subtotal",
                "DOP \$${controller.subtotal.value.toStringAsFixed(2)}", 200),
            const SizedBox(height: 6.0),
            if (controller.cartItems.isNotEmpty)
              Column(
                children: [
                  digitSection("Tax",
                      "DOP \$${controller.tax.value.toStringAsFixed(2)}", 400),
                  const SizedBox(height: 6.0),
                ],
              ),
            if (controller.cartItems.isNotEmpty)
              Column(
                children: [
                  digitSection(
                      "Discount",
                      "${controller.qty.value.isNotEmpty ? controller.qty.value : "0"}%",
                      600),
                  const SizedBox(height: 6.0),
                ],
              ),
            digitSection("Total",
                "DOP \$${controller.total.value.toStringAsFixed(2)}", 800),
          ],
        ),
      ),
    );
  }

  Widget digitSection(String title, dynamic amount, int delay) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
          delay: Duration(milliseconds: delay)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          digitText(title),
          digitText(amount),
        ],
      ),
    );
  }

  Widget digitText(String title) {
    return GestureDetector(
      onTap: title == "Discount"
          ? () => controller.isDiscountFieldVisible.value =
              !controller.isDiscountFieldVisible.value
          : null,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Themes.kBlackColor,
            ),
          ),
          if (title == "Discount")
            Row(
              children: [
                const SizedBox(width: 8.0),
                Image.asset(Images.edit, height: 14.0),
                const SizedBox(width: 8.0),
                Obx(() {
                  if (controller.isDiscountFieldVisible.value) {
                    return Container(
                      height: 28.0,
                      width: 78.0,
                      padding: const EdgeInsets.only(bottom: 3.5),
                      decoration: BoxDecoration(
                          color: Themes.kWhiteColor,
                          borderRadius: BorderRadius.circular(5.5),
                          border:
                              Border.all(width: 0.5, color: Themes.kGreyColor)),
                      child: TextFormField(
                        cursorHeight: 12.0,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                            fontSize: 12.0, color: Themes.kBlackColor),
                        controller: controller.qtyController,
                        decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                          border: InputBorder.none,
                          hintText: title,
                          hintStyle: TextStyle(
                            fontSize: 12.0,
                            color: Themes.kGreyColor[500],
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            controller.qtyController.text = value;
                            controller.qty.value = value;
                            controller.discountPercentage.value =
                                double.tryParse(value) ?? 0.0;
                            controller.calculateTotals();
                          });
                        },
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                })
              ],
            ),
        ],
      ),
    );
  }

  Widget bottomButtons() {
    return SafeArea(
      child: Row(
        children: [
          customButton("Pay", Themes.kPrimaryColor, Themes.kWhiteColor),
          customButton("Clear", Themes.kPrimaryColor.withOpacity(0.1),
              Themes.kBlackColor),
        ],
      ),
    );
  }

  Widget customButton(String title, dynamic btnColor, dynamic txtColor) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          onTap: () {
            if (title == "Clear" && controller.cartItems.isNotEmpty) {
              clearOrder(context);
            } else if (title == "Pay") {}
          },
          child: Ink(
            color: btnColor,
            child: Container(
              height: 52.0,
              width: Get.width / 2,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: txtColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic clearOrder(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomDialog(
            title: 'Are you sure?',
            msg: 'This order will be cancelled.',
            positiveAction: controller.clearCart));
  }

  Widget searchBar() {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48.0,
                padding: const EdgeInsets.only(left: 8.0, right: 24.0),
                decoration: BoxDecoration(
                  color: Themes.kPrimaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(48.0),
                    bottomLeft: Radius.circular(48.0),
                  ),
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Search Customers",
                    hintStyle: TextStyle(
                      color: Themes.kGreyColor[500],
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Image.asset(
                        Images.search,
                        height: 24.0,
                        color: Themes.kGreyColor[500],
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Material(
              color: Themes.kTransparent,
              child: InkWell(
                onTap: () => Constants.openDialog(
                  context: context,
                  title: "Add Customer",
                  btnText1: "Proceed",
                  scroll: const AlwaysScrollableScrollPhysics(),
                  child: Constants.inputSection(),
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(48.0),
                  bottomRight: Radius.circular(48.0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Themes.kPrimaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(48.0),
                      bottomRight: Radius.circular(48.0),
                    ),
                  ),
                  child: Container(
                    height: 48.0,
                    width: 58.0,
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      Images.add,
                      height: 14.0,
                      width: 14.0,
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
}
