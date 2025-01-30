import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_dropdown.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/common_controller.dart';

class ProductInfo extends StatefulWidget {
  final dynamic itemData;
  final int index;
  const ProductInfo({super.key, this.itemData, required this.index});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    commonController.isKeyboardVisible =
        MediaQuery.of(context).viewInsets.bottom > 0;

    double modalSize = commonController.isKeyboardVisible ? 0.92 : 0.6;

    return DraggableScrollableSheet(
      initialChildSize: modalSize, // Opens at 1/3 screen height
      minChildSize: modalSize, // Minimum 1/3 screen height
      maxChildSize: modalSize, // Maximum full screen height
      snap: false,
      // snapSizes: const [0.3, 0.6, 0.9],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.circular(28.0),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              closeButton(),
              Padding(
                padding:
                    const EdgeInsets.only(top: 32.0, left: 24.0, right: 24.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(90.0),
                          child: Image.asset(
                            widget.itemData["image"],
                            height: 90.0,
                            width: 90.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 24.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.itemData["title"],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Themes.kBlackColor,
                              ),
                            ),
                            Text(
                              "\$${widget.itemData["price"]}",
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: Themes.kBlackColor,
                              ),
                            ),
                            Text(
                              widget.index % 2 == 1 ? "Out of stock" : "",
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Themes.kRedColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Lorem ipsum dolor sit amet consectetur. Gravida vulputate senectus cras id vel. Vulputate tortor turpis fames ut pulvinar sed sagittis. Velit convallis commodo pretium amet suscipit pretium orci.",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Themes.kBlackColor,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        submitButton(),
                        const SizedBox(width: 32.0),
                        Row(
                          children: [
                            qtyButton(Images.less, "Decrease"),
                            const SizedBox(width: 12.0),
                            const Text(
                              "1",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Themes.kBlackColor,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            qtyButton(Images.add, "Increase"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    CustomDropdowns(
                        isMultiSelect: true,
                        listData: DummyData.extraItems,
                        hintText: "Extra Items"),
                    const SizedBox(height: 16.0),
                    CustomDropdowns(
                        isMultiSelect: true,
                        listData: DummyData.formulaItems,
                        hintText: "Formula Items"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget qtyButton(String image, String type) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(7.0),
        onTap: () {},
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

  Widget submitButton() {
    return Expanded(
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            Get.back();
            Constants.showSnackBar(context, "SUCCESS", "Item Added!");
          },
          child: Ink(
            decoration: BoxDecoration(
              color: Themes.kPrimaryColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Themes.kWhiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(),
        child: Material(
          color: Themes.kTransparent,
          child: InkWell(
            onTap: () => Get.back(),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(28.0),
              bottomLeft: Radius.circular(28.0),
              topLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Themes.kPrimaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28.0),
                  bottomLeft: Radius.circular(28.0),
                  topLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: Container(
                height: 54.0,
                width: 54.0,
                padding: const EdgeInsets.all(21.0),
                child: Image.asset(
                  Images.close,
                  color: Themes.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
