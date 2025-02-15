import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_search_bar.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/common_controller.dart';

class AllOrdersView extends StatefulWidget {
  const AllOrdersView({super.key});

  @override
  State<AllOrdersView> createState() => _AllOrdersViewState();
}

class _AllOrdersViewState extends State<AllOrdersView> {
  dynamic data = Get.arguments;
  final CommonController commonController = Get.find<CommonController>();

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
          children: [
            customHeader(),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: CustomSearchBar(isEnabled: true, title: "Search Order"),
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
                        child: orderItem(size, index, itemWidth),
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

  Widget orderItem(Size size, int index, double itemWidth) {
    String title = data["title"];

    return Container(
      width: itemWidth,
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
                                title == "Draft"
                                    ? "Draft"
                                    : title.contains("Deleted")
                                        ? "Deleted"
                                        : "Paid",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: title == "Draft"
                                      ? Themes.kOrangeColor
                                      : title.contains("Deleted")
                                          ? Themes.kRedColor
                                          : Themes.kGreenColor,
                                  height: 0.0,
                                ),
                              ),
                              Text(
                                index % 2 == 0
                                    ? "Empresa Distribuidora De Electricidad Del"
                                    : "Paloma Medrano",
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
                "\$512.16",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Themes.kBlackColor,
                  height: 0.0,
                ),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                onTapDown: (details) => Constants.openPopupMenu(
                    context, details, DummyData.actionItems, "Items"),
                child: Image.asset(
                  Images.moreNew,
                  height: 20.0,
                  width: 20.0,
                  color: Themes.kBlackColor,
                ),
              ),
            ],
          ),
          // Expandable section remains the same
          Obx(() => commonController.expandedIndex.value == index
              ? Column(
                  children: [
                    const SizedBox(height: 12.0),
                    cartBullet(
                        title.contains("All") ? "Invoice No." : "Table",
                        title.contains("All")
                            ? "SC009238110"
                            : "Table 56 (Chair 5)"),
                    spaceBetween(size),
                    cartBullet(title.contains("All") ? "NFC" : "Order No.",
                        title.contains("All") ? "B0100000147" : "14212"),
                    spaceBetween(size),
                    cartBullet("Date", "01/01/2025"),
                    spaceBetween(size),
                    cartBullet("Time", "02:58 AM"),
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
              onTapDown: (details) => Constants.openPopupMenu(
                  context, details, DummyData.ordersFilters, "Items"),
              child: Image.asset(Images.filters, height: 20.0),
            ),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTapDown: (details) => Constants.openPopupMenu(
                  context, details, DummyData.exportItems, "Items"),
              child: Image.asset(Images.export, height: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
