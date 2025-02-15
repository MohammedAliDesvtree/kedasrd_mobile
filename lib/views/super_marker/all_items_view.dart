import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_search_bar.dart';

import 'package:kedasrd/views/fastfood/filter_view.dart';
import 'package:kedasrd/views/pos/add_customer_view.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

import 'package:kedasrd/controllers/common_controller.dart';

class AllItemsView extends StatefulWidget {
  const AllItemsView({super.key});

  @override
  State<AllItemsView> createState() => _AllItemsViewState();
}

class _AllItemsViewState extends State<AllItemsView> {
  final CommonController commonController = Get.find<CommonController>();
  dynamic data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customHeader(),
            if (data["title"] == "Customers")
              const Padding(
                padding: EdgeInsets.only(left: 24.0, bottom: 14.0),
                child: Text(
                  "Paloma Medrano",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Themes.kBlackColor,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CustomSearchBar(
                  isEnabled: true,
                  title: data["title"] == "Items"
                      ? "Search Item"
                      : "Search Customer"),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(5, (index) {
                      // Calculate item width based on orientation
                      final itemWidth = isPortrait
                          ? size.width - 32 // Account for padding
                          : (size.width / 2.2);

                      return WidgetAnimator(
                        incomingEffect:
                            WidgetTransitionEffects.incomingSlideInFromRight(
                                delay: Duration(milliseconds: index * 200)),
                        child: data["title"] == "Items"
                            ? itemView(size, index, itemWidth)
                            : customerView(size, index, itemWidth),
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget customerView(Size size, int index, double itemWidth) {
    return Container(
      width: itemWidth,
      margin: const EdgeInsets.only(top: 4.0),
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
          Row(
            children: [
              // Clickable section containing status, title, and arrow
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior
                      .opaque, // Makes the entire row area tappable
                  onTap: () => commonController.toggleItemExpansion(index),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            index % 2 == 0
                                ? "Empresa Distribuidora De Electricidad Del"
                                : "Paloma Medrano",
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Themes.kBlackColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Image.asset(
                          Images.downArrow,
                          height: 14.0,
                          width: 14.0,
                          fit: BoxFit.contain,
                          color: Themes.kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Non-clickable price and more options
              const SizedBox(width: 16.0),
              const Text(
                "\$0.00",
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
                    context, "SUCCESS", "Customer Selected"),
                child: Image.asset(
                  Images.touchscreen,
                  height: 20.0,
                  width: 20.0,
                  color: Themes.kPrimaryColor,
                ),
              ),
            ],
          ),
          // Expandable section remains the same
          Obx(() => commonController.expandedIndex.value == index
              ? Column(
                  children: [
                    const SizedBox(height: 8.0),
                    cartBullet("Phone No.", "0276744518"),
                    spaceBetween(size),
                    cartBullet("Mobile", "9856320147"),
                    spaceBetween(size),
                    cartBullet("Email", "mesa10@kedas.com"),
                    spaceBetween(size),
                    cartBullet("Tax ID", "131174884"),
                    const SizedBox(height: 8.0),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget spaceBetween(size) {
    return Column(
      children: [
        const SizedBox(height: 4.0),
        Constants.divider(size),
        const SizedBox(height: 4.0),
      ],
    );
  }

  Widget itemView(Size size, int index, double itemWidth) {
    return Container(
      width: itemWidth,
      margin: const EdgeInsets.only(top: 4.0),
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
          Row(
            children: [
              // Clickable section containing status, title, and arrow
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior
                      .opaque, // Makes the entire row area tappable
                  onTap: () => commonController.toggleItemExpansion(index),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                index % 3 != 1 ? "In Stock" : "Out Of Stock",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: index % 3 != 1
                                      ? Themes.kGreenColor
                                      : Themes.kOrangeColor,
                                  height: 0.0,
                                ),
                              ),
                              Text(
                                index % 3 != 1
                                    ? "Nachitos Ricos"
                                    : "Salted Tahini Chocolate Chunk (1 ud)",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Themes.kBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Image.asset(
                          Images.downArrow,
                          height: 14.0,
                          width: 14.0,
                          fit: BoxFit.contain,
                          color: Themes.kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Non-clickable price and more options
              const SizedBox(width: 16.0),
              const Text(
                "DOP \$512.16",
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
                    context, "SUCCESS", "Item added successfully!"),
                child: Image.asset(
                  Images.addToCart,
                  height: 24.0,
                  width: 24.0,
                  color: Themes.kPrimaryColor,
                ),
              ),
            ],
          ),
          // Expandable section
          Obx(() => commonController.expandedIndex.value == index
              ? Column(
                  children: [
                    const SizedBox(height: 8.0),
                    cartBullet("Code", "64913826"),
                    const SizedBox(height: 8.0),
                  ],
                )
              : const SizedBox.shrink()),
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
        Text(
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

  Widget itemBullet(String title, String type) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: type == "Key" ? FontWeight.w400 : FontWeight.w600,
        color: title.contains("In")
            ? Themes.kGreenColor
            : title.contains("Out")
                ? Themes.kOrangeColor
                : type == "Key"
                    ? Themes.kPrimaryColor
                    : Themes.kBlackColor,
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
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset(
                Images.leftArrow,
                height: 22.0,
                color: Themes.kBlackColor,
              ),
            ),
            Expanded(
              child: Text(
                data["title"],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Themes.kBlackColor,
                ),
              ),
            ),
            if (data["title"] == "Items")
              Row(
                children: [
                  GestureDetector(
                    onTap: () => openBottomSheet(data["title"]),
                    child: Image.asset(Images.filters, height: 20.0),
                  ),
                  const SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: () => Constants.showSnackBar(
                        context, "SUCCESS", "Add Product"),
                    child: Image.asset(Images.add, height: 14.0),
                  ),
                ],
              ),
            if (data["title"] == "Customers")
              GestureDetector(
                onTap: () => Constants.openDialog(
                  context: context,
                  title: "Add Customer",
                  btnText1: "Proceed",
                  scroll: const AlwaysScrollableScrollPhysics(),
                  child: Constants.inputSection(),
                ),
                child: Image.asset(Images.add, height: 14.0),
              )
          ],
        ),
      ),
    );
  }

  dynamic openBottomSheet(String title) {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true, // To allow full screen dragging
        backgroundColor: Themes.kTransparent,
        builder: (context) =>
            title == "Items" ? const FilterView() : const AddCustomerView());
  }
}
