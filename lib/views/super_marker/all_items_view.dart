import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_search_bar.dart';

import 'package:kedasrd/views/fastfood/filter_view.dart';
import 'package:kedasrd/views/pos/add_customer_view.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

class AllItemsView extends StatefulWidget {
  const AllItemsView({super.key});

  @override
  State<AllItemsView> createState() => _AllItemsViewState();
}

class _AllItemsViewState extends State<AllItemsView> {
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
                    spacing: 16.0,
                    runSpacing: 16.0,
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
    return GestureDetector(
      onTap: () =>
          Constants.showSnackBar(context, "SUCCESS", "Customer Selected"),
      child: Container(
        // height: 56.0,
        width: itemWidth,
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      itemBullet("Name", "Key"),
                      itemBullet("Paloma Medrano", "Value"),
                    ],
                  ),
                  Constants.divider(size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      itemBullet("Phone No.", "Key"),
                      itemBullet("0276744518", "Value"),
                    ],
                  ),
                  Constants.divider(size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      itemBullet("Mobile", "Key"),
                      itemBullet("9856320147", "Value"),
                    ],
                  ),
                  Constants.divider(size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      itemBullet("Email", "Key"),
                      itemBullet("mesa10@kedas.com", "Value"),
                    ],
                  ),
                  Constants.divider(size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      itemBullet("Tax ID", "Key"),
                      itemBullet("131174884", "Value"),
                    ],
                  ),
                  Constants.divider(size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      itemBullet("Balance", "Key"),
                      itemBullet("0.00000", "Value"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemView(Size size, int index, double itemWidth) {
    return Container(
      // height: 56.0,
      width: itemWidth,
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    itemBullet("Item Description", "Key"),
                    itemBullet("Nachitos Ricos", "Value"),
                  ],
                ),
                Constants.divider(size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    itemBullet("Code", "Key"),
                    itemBullet("64913826", "Value"),
                  ],
                ),
                Constants.divider(size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    itemBullet("Price", "Key"),
                    itemBullet("DOP \$512.16", "Value"),
                  ],
                ),
                Constants.divider(size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    itemBullet("Status", "Key"),
                    itemBullet(
                        index % 3 != 1 ? "In Stock" : "Out Of Stock", "Value"),
                  ],
                ),
                Constants.divider(size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    itemBullet("Discount", "Key"),
                    itemBullet("\$0.00", "Value"),
                  ],
                ),
              ],
            ),
          ),
          Material(
            color: Themes.kTransparent,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              onTap: () => Constants.showSnackBar(
                  context, "SUCCESS", "Item added successfully!"),
              child: Ink(
                decoration: const BoxDecoration(
                  color: Themes.kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Container(
                  width: 80.0,
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
        ],
      ),
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
