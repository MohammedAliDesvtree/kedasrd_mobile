import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_bottom_sheet.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

class AllOrdersView extends StatefulWidget {
  const AllOrdersView({super.key});

  @override
  State<AllOrdersView> createState() => _AllOrdersViewState();
}

class _AllOrdersViewState extends State<AllOrdersView> {
  dynamic data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            customHeader(),
            searchBar(),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: List.generate(5, (index) {
                      return WidgetAnimator(
                        incomingEffect:
                            WidgetTransitionEffects.incomingSlideInFromRight(
                                delay: Duration(milliseconds: index * 200)),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14.0),
                          child: orderItem(size, index),
                        ),
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

  Widget orderItem(Size size, int index) {
    String title = data["title"];
    return Container(
      // height: 56.0,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
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
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width / 4.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        itemBullet("Customer", "Key"),
                        itemBullet("Paloma Medrano", "Value"),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        itemBullet(
                            title == "Draft" || title.contains("Deleted")
                                ? "Status"
                                : "NCF",
                            "Key"),
                        itemBullet(
                            title == "Draft"
                                ? "Draft"
                                : title.contains("Deleted")
                                    ? "Deleted"
                                    : "B0100000147",
                            "Value"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width / 4.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        itemBullet(
                            title == "Draft" || title.contains("Deleted")
                                ? "Table"
                                : "Invoice No.",
                            "Key"),
                        itemBullet(
                            title == "Draft" || title.contains("Deleted")
                                ? "Table 56 (Chair 5)"
                                : "SC009238110",
                            "Value"),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        itemBullet("Date", "Key"),
                        itemBullet("01/01/2025", "Value"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width / 6.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        itemBullet(
                            title == "Draft" || title.contains("Deleted")
                                ? "Order No."
                                : "Total",
                            "Key"),
                        itemBullet(
                            title == "Draft" || title.contains("Deleted")
                                ? "141212"
                                : "\$512.16",
                            "Value"),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        itemBullet("Time", "Key"),
                        itemBullet("02:58 AM", "Value"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width / 6.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        itemBullet(
                            title == "Draft" || title.contains("Deleted")
                                ? "Total"
                                : "Status",
                            "Key"),
                        itemBullet(
                            title == "Draft" || title.contains("Deleted")
                                ? "\$1605"
                                : (title == "All Orders" ||
                                        title == "Orders" && index % 2 != 1)
                                    ? "Paid"
                                    : (title == "All Orders" ||
                                            title == "Orders" && index % 3 != 1)
                                        ? "Draft"
                                        : "Deleted",
                            "Value"),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        itemBullet("", "Key"),
                        itemBullet("", "Value"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 6.0,
            right: 0.0,
            child: GestureDetector(
              onTap: () => openBottomSheet("Share", DummyData.actionItems),
              child: Image.asset(
                Images.more,
                height: 12.0,
                color: Themes.kPrimaryColor,
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
        fontSize: 10.0,
        fontWeight: type == "Key" ? FontWeight.w400 : FontWeight.w600,
        color: title == "Paid"
            ? Themes.kGreenColor
            : title == "Draft"
                ? Themes.kOrangeColor
                : title == "Deleted"
                    ? Themes.kRedColor
                    : type == "Key"
                        ? Themes.kPrimaryColor
                        : Themes.kBlackColor,
      ),
    );
  }

  Widget searchBar() {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(),
      child: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
        padding: const EdgeInsets.only(left: 24.0, right: 10.0),
        decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(48.0),
          boxShadow: [
            BoxShadow(
              color: Themes.kBlackColor.withOpacity(0.20),
              blurRadius: 8.0,
              spreadRadius: -3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            border: InputBorder.none,
            hintText: "Search Order",
            hintStyle: TextStyle(color: Themes.kGreyColor[500]),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Image.asset(
                Images.search,
                height: 24.0,
                color: Themes.kGreyColor[500],
              ),
            ),
          ),
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
            GestureDetector(
              onTap: () =>
                  openBottomSheet("Select Filter", DummyData.ordersFilters),
              child: Image.asset(Images.filters, height: 20.0),
            ),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTap: () => openBottomSheet("Export", DummyData.exportItems),
              child: Image.asset(Images.export, height: 20.0),
            ),
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
}
