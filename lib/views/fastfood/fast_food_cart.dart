import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_dialog.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/views/pos/add_customer_view.dart';

import 'package:kedasrd/controllers/auth/auth_controller.dart';
import 'package:kedasrd/controllers/fastfood/fast_food_cart_controller.dart';

class FastFoodCart extends StatefulWidget {
  const FastFoodCart({super.key});

  @override
  State<FastFoodCart> createState() => _FastFoodCartState();
}

class _FastFoodCartState extends State<FastFoodCart> {
  dynamic data = Get.arguments;
  final GlobalKey<ScaffoldState> fastFoodCartGlobalKey = GlobalKey();
  FastFoodCartController controller = Get.put(FastFoodCartController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: fastFoodCartGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(
          screenName: "Online Store",
          items: data["title"] == "Online Store"
              ? DummyData.onlineStoreDrawerItems
              : DummyData.fastFoodDrawerItems),
      bottomNavigationBar: data["title"] == "Online Store"
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    checkoutButton("Discard Order", size),
                    checkoutButton("Confirm Order", size),
                  ],
                ),
              ),
            )
          : Container(
              height: 84.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Themes.kWhiteColor,
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 6.0),
                  bottomButtons(isPortrait, size),
                ],
              ),
            ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
                title: "Cart",
                onMenuTapped: () =>
                    fastFoodCartGlobalKey.currentState!.openDrawer()),
            customerDetails(),
            data["title"] == "Online Store"
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      const SizedBox(height: 14.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Dine In | User : Paloma Medrano",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Themes.kBlackColor,
                              ),
                            ),
                            GestureDetector(
                              onTapDown: (details) => Constants.openPopupMenu(
                                  context,
                                  details,
                                  DummyData.cartOptionsItems,
                                  "Regular - User"),
                              child: Image.asset(
                                Images.more,
                                height: 14.0,
                                color: Themes.kBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

            const SizedBox(height: 14.0),
            // data["title"] == "Delivery"
            //     ?
            Expanded(
              child: Column(
                children: [
                  cartItems(size, isPortrait),
                  // const Spacer(),
                ],
              ),
            ),
            // : emptySection(),
            totalView(),
            const SizedBox(height: 4.0),
            Obx(() {
              if (controller.isDigitsViewVisible.value) {
                return Column(
                  children: [
                    digitsView(),
                    const SizedBox(height: 4.0),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            })
          ],
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
            const Row(
              children: [
                Text(
                  "2 Items",
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

  Widget customerDetails() {
    return Obx(
      () => Row(
        children: [
          controller.isNameVisible.value
              ? Expanded(
                  child: Container(
                    height: 46.0,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 8.0),
                    margin: const EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                        color: Themes.kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Stack(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Paloma Medrano",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Themes.kBlackColor,
                              ),
                            ),
                            Text(
                              "ccmatua@kedasrd.com - 809-536-9566",
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Themes.kBlackColor,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 2.0,
                          right: 2.0,
                          child: GestureDetector(
                            onTap: () => controller.isNameVisible.value = false,
                            child: Image.asset(
                              Images.close,
                              height: 8.0,
                              color: Themes.kPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Themes.kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Customer",
                        hintStyle: TextStyle(
                          color: Themes.kGreyColor[500],
                        ),
                      ),
                    ),
                  ),
                ),
          data["title"] == "Online Store"
              ? const SizedBox(width: 16.0)
              : GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isDismissible: false,
                    enableDrag: false,
                    isScrollControlled: true, // To allow full screen dragging
                    backgroundColor: Themes.kTransparent,
                    builder: (context) {
                      return const AddCustomerView();
                    },
                  ),
                  child: Container(
                    height: controller.isNameVisible.value ? 46.0 : 48.0,
                    padding: EdgeInsets.all(
                        controller.isNameVisible.value ? 16.0 : 16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        color: Themes.kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Image.asset(
                      Images.add,
                      height: 12.0,
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                ),
        ],
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
            positiveAction: () => {
                  Constants.showSnackBar(context, "SUCCESS", "Order Cancelled"),
                  Get.back(),
                }));
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

  Widget cartItems(Size size, bool isPortrait) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(1, (index) {
            return WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                  delay: const Duration(milliseconds: 150)),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (authController.isAdmin) {
                              Constants.showSnackBar(
                                  context, "SUCCESS", "Item Removed!");
                            } else {
                              Constants.enterAuthCode(
                                  context: context,
                                  isPortrait: isPortrait,
                                  size: size,
                                  screen: "Cart");
                            }
                          },
                          child: Image.asset(
                            Images.delete,
                            height: 16.0,
                            color: Themes.kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        GestureDetector(
                          onTapDown: (details) => Constants.openPopupMenu(
                              context,
                              details,
                              DummyData.cartSingleItems,
                              "Regular - Item"),
                          child: Image.asset(
                            Images.more,
                            height: 14.0,
                            color: Themes.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    cartBullet("Items", "Nachitos Ricos"),
                    Constants.divider(size),
                    cartBullet("Qty", "0"),
                    Constants.divider(size),
                    SizedBox(
                        height: data["title"] == "Online Store" ? 8.0 : 0.0),
                    cartBullet("Price", "DOP \$11.00"),
                    Constants.divider(size),
                    SizedBox(
                        height: data["title"] == "Online Store" ? 8.0 : 0.0),
                    data["title"] == "Online Store"
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              cartBullet("Disc %", "0"),
                              Constants.divider(size),
                            ],
                          ),
                    cartBullet("Total", "DOP \$22.00"),
                  ],
                ),
              ),
            );
          }),
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
          qtyButton(Images.less, "Decrease", 0),
          const Text(
            "2",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Themes.kBlackColor,
            ),
          ),
          qtyButton(Images.add, "Increase", 0),
        ],
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
        title.contains("Disc") ||
                (title == "Price" && data["title"] != "Online Store")
            ? inputView(title)
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

  Widget inputView(String title) {
    return Container(
      height: 26.0,
      width: title == "Price" ? 74.0 : 32.0,
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
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title == "Price" ? "\$500.00" : "0",
          hintStyle: const TextStyle(
            fontSize: 12.0,
            color: Themes.kBlackColor,
          ),
        ),
      ),
    );
  }

  Widget qtyButton(String image, String type, int index) {
    return GestureDetector(
      onTap: () {
        if (type == "Decrease") {
        } else {}
      },
      child: Image.asset(
        image,
        height: 11.0,
        width: 11.0,
        color: Themes.kPrimaryColor,
      ),
    );
  }

  Widget checkoutButton(String title, Size size) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          if (title.contains("Confirm")) {
            Get.toNamed(Routes.INFO);
          } else {
            Constants.discardOrder(context);
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            height: 54.0,
            width: size.width / 2.2,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomButtons(bool isPortrait, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Constants.openBottomSheet(
              context, "Payment Options", DummyData.payItems),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
            decoration: BoxDecoration(
                color: const Color(0xFF539717),
                borderRadius: BorderRadius.circular(6.0)),
            child: const Text(
              "Pay \$1024.32",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Themes.kWhiteColor),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                customButton(isPortrait, size, "Save Item"),
                const SizedBox(width: 8.0),
                closeButton(),
              ],
            ),
            const SizedBox(height: 6.0),
            customButton(isPortrait, size, "Send Order To Kitchen"),
          ],
        ),
      ],
    );
  }

  Widget closeButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(3.0),
        onTap: () => clearOrder(context),
        child: Ink(
          decoration: BoxDecoration(
              color: Themes.kGreyColor[300],
              borderRadius: BorderRadius.circular(3.0)),
          child: Container(
            height: 26.0,
            width: 26.0,
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Images.close,
              color: Themes.kRedColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget customButton(bool isPortrait, Size size, String title) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          onTap: () {
            if (title.contains("Send")) {
              if (authController.isAdmin) {
                Get.toNamed(Routes.INVOICE);
              } else {
                Constants.enterAuthCode(
                    context: context,
                    isPortrait: isPortrait,
                    size: size,
                    screen: "FastFood");
              }
            } else {
              Constants.showSnackBar(
                  context, "SUCCESS", "Save Order Successfully!");
            }
          },
          child: Ink(
            decoration: BoxDecoration(
                color: title.contains("Kitchen")
                    ? Themes.kPrimaryColor
                    : Themes.kPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(3.0)),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset(
                    title.contains("Kitchen")
                        ? Images.purchaseOrder
                        : Images.save,
                    height: 14.0,
                    width: 14.0,
                    color: Themes.kWhiteColor,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget digitsView() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
      child: data["title"] != "Online Store"
          ? Column(
              children: [
                digitSection("Subtotal", "DOP \$847.46", 200),
                const SizedBox(height: 6.0),
                digitSection("Tax", "DOP \$152.54", 400),
                const SizedBox(height: 6.0),
                digitSection("Tips Tax", "\$24.32", 600),
                const SizedBox(height: 6.0),
                Obx(() => digitSection(
                    "Discount", "\$${controller.qty.value}.00", 800)),
                const SizedBox(height: 6.0),
                digitSection("Total", "DOP \$1,024.32", 1000),
              ],
            )
          : Column(
              children: [
                digitSection("Subtotal", "DOP \$22.00", 150),
                const SizedBox(height: 6.0),
                digitSection("Tax", "DOP \$0.00", 300),
                const SizedBox(height: 6.0),
                digitSection("Total", "DOP \$22.00", 450),
              ],
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
            style: TextStyle(
              fontSize:
                  title == "Total" || title.contains("1,024") ? 18.0 : 15.0,
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
}
