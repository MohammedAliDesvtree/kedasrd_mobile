import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';

import 'package:kedasrd/controllers/pos/add_customer_controller.dart';

class PaymentInfoView extends StatefulWidget {
  const PaymentInfoView({super.key});

  @override
  State<PaymentInfoView> createState() => _PaymentInfoViewState();
}

class _PaymentInfoViewState extends State<PaymentInfoView> {
  AddCustomerController controller = Get.put(AddCustomerController());
  bool isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    double modalSize = isKeyboardVisible ? 0.9 : 0.6;
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
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromTop(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
                  child: Text(
                    "Payment Info".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                ),
              ),
              closeButton(),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                child: inputSection(),
              ),
              Positioned(
                bottom: 16.0,
                child: WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromBottom(),
                  child: SafeArea(
                    child: submitButton(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget submitButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        onTap: () {
          Constants.showSnackBar(context, "Order Successfully Created!");
          Get.offAllNamed("/home");
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Container(
            height: 52.0,
            width: Get.width / 2,
            alignment: Alignment.center,
            child: const Text(
              "Pay",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 84.0),
      child: Column(
        children: [
          inputView("Name", controller.nameController),
          const SizedBox(height: 28.0),
          inputView("Card Number", controller.taxIDController),
          const SizedBox(height: 28.0),
          inputView("Expiry Date", controller.phoneNumberController),
          const SizedBox(height: 28.0),
          inputView("CVV", controller.phoneNumberController),
        ],
      ),
    );
  }

  Widget inputView(String title, TextEditingController controller) {
    return Stack(
      // clipBehavior: Clip.none,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: TextFormField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              // contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              border: InputBorder.none,
              hintText: title,
              hintStyle: TextStyle(
                color: Themes.kGreyColor[500],
              ),
            ),
            onChanged: (value) {
              setState(() {
                controller.text = value;
              });
            },
          ),
        ),
        if (controller.text.isNotEmpty)
          Positioned(
            top: -10.0,
            left: 16.0,
            // padding: const EdgeInsets.only(left: 16.0, bottom: 2.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
      ],
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
