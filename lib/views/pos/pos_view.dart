import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_search_bar.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/pos/pos_controller.dart';
import 'package:kedasrd/controllers/pos/cart_controller.dart';

class POSView extends StatefulWidget {
  const POSView({super.key});

  @override
  State<POSView> createState() => _POSViewState();
}

class _POSViewState extends State<POSView> {
  final GlobalKey<ScaffoldState> posGlobalKey = GlobalKey();
  final POSController controller = Get.find<POSController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    controller.isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      key: posGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.posDrawerItems),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                CustomHeader(
                    title: "Regular",
                    onMenuTapped: () =>
                        posGlobalKey.currentState!.openDrawer()),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child:
                      CustomSearchBar(isEnabled: true, title: "Search Product"),
                ),
                const SizedBox(height: 16.0),
                productList(isPortrait, size),
              ],
            ),
          ),
          if (!controller.isKeyboardVisible)
            Obx(() {
              if (cartController.cartItems.isNotEmpty) {
                return Positioned(
                  bottom: 8.0,
                  left: 0.0,
                  right: 0.0,
                  child: WidgetAnimator(
                    incomingEffect:
                        WidgetTransitionEffects.incomingSlideInFromBottom(),
                    child: Container(
                      height: 67.0,
                      margin: const EdgeInsets.only(
                          bottom: 24.0, left: 32.0, right: 32.0),
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
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
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${cartController.cartItems.length} Item",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Themes.kGreyColor,
                                  ),
                                ),
                                Text(
                                  "DOP \$${cartController.subtotal.value.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Themes.kBlackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Material(
                            color: Themes.kTransparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () => Get.toNamed(Routes.CART),
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
              } else {
                return const SizedBox.shrink();
              }
            }),
        ],
      ),
    );
  }

  Widget productList(bool isPortrait, Size size) {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children:
                    List.generate(controller.filteredList.length, (index) {
                  var data = controller.filteredList[index];

                  // Calculate item width based on orientation
                  final itemWidth = isPortrait
                      ? size.width - 32 // Account for padding
                      : (size.width / 2.2);

                  return WidgetAnimator(
                    incomingEffect:
                        WidgetTransitionEffects.incomingSlideInFromRight(
                            delay: Duration(milliseconds: index * 150)),
                    child: Stack(
                      children: [
                        Container(
                          height: 124.0,
                          width: itemWidth,
                          // margin: const EdgeInsets.only(
                          //     left: 16.0, right: 16.0, bottom: 16.0),
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
                                //
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 116.0,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: -74.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(68.0),
                                                      bottomRight:
                                                          Radius.circular(
                                                              68.0)),
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            "DOP \$${data["price"]}",
                                            style: const TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w700,
                                              color: Themes.kBlackColor,
                                            ),
                                          ),
                                          Container(
                                            // width: size.width / 1.7,
                                            margin:
                                                const EdgeInsets.only(top: 6.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Obx(() {
                                                  // Check if item exists in cart
                                                  final cartItemIndex =
                                                      cartController.cartItems
                                                          .indexWhere((item) =>
                                                              item.name ==
                                                              data["title"]);

                                                  if (cartItemIndex != -1) {
                                                    // Show quantity controls if item is in cart
                                                    return SizedBox(
                                                      width: 84.0,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          qtyButton(
                                                              Images.less,
                                                              "Increase",
                                                              cartItemIndex),
                                                          Text(
                                                            "${cartController.cartItems[cartItemIndex].quantity.value}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Themes
                                                                  .kBlackColor,
                                                            ),
                                                          ),
                                                          qtyButton(
                                                              Images.add,
                                                              "Decrease",
                                                              cartItemIndex),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox
                                                        .shrink(); // Hide controls if not in cart
                                                  }
                                                }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() {
                                  // Check if item exists in cart
                                  final cartItemIndex = cartController.cartItems
                                      .indexWhere(
                                          (item) => item.name == data["title"]);

                                  if (cartItemIndex == -1 && index % 2.5 != 2) {
                                    // Show controls if item is in cart
                                    return Positioned(
                                      bottom: 0.0,
                                      right: 0.0,
                                      child: Material(
                                        color: Themes.kTransparent,
                                        child: InkWell(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(13.0),
                                            bottomRight: Radius.circular(8.0),
                                          ),
                                          onTap: () => controller.addToCart(
                                              data["title"], data["price"], 1),
                                          child: Ink(
                                            decoration: const BoxDecoration(
                                              color: Themes.kPrimaryColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13.0),
                                                bottomRight:
                                                    Radius.circular(8.0),
                                              ),
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 16.0),
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
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                }),
                              ],
                            ),
                          ),
                        ),
                        if (index % 2.5 == 2)
                          Container(
                            height: 124.0,
                            width: itemWidth,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 36.0),
                            decoration: BoxDecoration(
                              color: Themes.kBlackColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              "Out\nOf\nStock",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Themes.kWhiteColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                })),
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
            cartController.updateQuantity(index, true);
          } else {
            cartController.updateQuantity(index, false);
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
}
