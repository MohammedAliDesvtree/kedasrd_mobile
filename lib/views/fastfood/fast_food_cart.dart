import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_dialog.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_bottom_sheet.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/views/pos/add_customer_view.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: fastFoodCartGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.fastFoodDrawerItems),
      bottomNavigationBar: data["title"] == "Online Store"
          ? checkoutButton()
          : Container(
              height: 124.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
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
                  Material(
                    color: Themes.kTransparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24.0),
                      onTap: () => clearOrder(context),
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Themes.kGreyColor[300],
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Container(
                          height: 24.0,
                          width: 24.0,
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            Images.close,
                            color: Themes.kRedColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  bottomButtons(),
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
                              onTap: () => openBottomSheet(
                                  "Options", DummyData.cartOptionsItems),
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
                  cartItems(size),
                  // const Spacer(),
                ],
              ),
            ),
            // : emptySection(),
            data["title"] == "Online Store"
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: digitSection("Total", "DOP \$1,024.32", 100),
                  )
                : totalView(),
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

  dynamic openBottomSheet(String title, List<String> data) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) {
        return CustomBottomSheet(title: title, listData: data);
      },
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
                            const Text(
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
                  showSnackBar(context, "Order Cancelled"),
                  Get.back(),
                }));
  }

  showSnackBar(context, msg) {
    var snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  Widget cartItems(Size size) {
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
                          onTap: () =>
                              Constants.showSnackBar(context, "Item Removed!"),
                          child: Image.asset(
                            Images.delete,
                            height: 16.0,
                            color: Themes.kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        GestureDetector(
                          onTap: () => openBottomSheet(
                              "Item Options", DummyData.cartSingleItems),
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
                    cartBullet("Price", "0"),
                    Constants.divider(size),
                    data["title"] == "Online Store"
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              cartBullet("Disc %", "0"),
                              Constants.divider(size),
                            ],
                          ),
                    cartBullet("Total", "\$500.00"),
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
        title.contains("Disc") || title == "Price"
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

  Widget checkoutButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () => Get.toNamed("/info"),
        child: Ink(
          decoration: const BoxDecoration(
            color: Themes.kPrimaryColor,
            // borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            height: 54.0,
            alignment: Alignment.center,
            child: const Text(
              "Add Address",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => openBottomSheet("Payment Options", DummyData.payItems),
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
            customButton("Send Order To Kitchen"),
            const SizedBox(height: 6.0),
            customButton("Save Item")
          ],
        ),
      ],
    );
  }

  Widget customButton(String title) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          onTap: () {
            if (title.contains("Send")) {
              showSnackBar(context, "Send Order to Kitchen Successfully!");
            } else {
              showSnackBar(context, "Save Order Successfully!");
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
      child: Column(
        children: [
          digitSection("Subtotal", "DOP \$847.46", 200),
          const SizedBox(height: 6.0),
          // if (data["title"] == "Delivery")
          digitSection("Tax", "DOP \$152.54", 400),
          const SizedBox(height: 6.0),
          // if (data["title"] == "Delivery")
          digitSection("Tips Tax", "\$24.32", 600),
          const SizedBox(height: 6.0),
          // if (data["title"] == "Delivery")
          Obx(() =>
              digitSection("Discount", "\$${controller.qty.value}.00", 800)),
          const SizedBox(height: 6.0),
          digitSection("Total", "DOP \$1,024.32", 1000)
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
