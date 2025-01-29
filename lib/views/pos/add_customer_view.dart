import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/controllers/pos/add_customer_controller.dart';

class AddCustomerView extends StatefulWidget {
  const AddCustomerView({super.key});

  @override
  State<AddCustomerView> createState() => _AddCustomerViewState();
}

class _AddCustomerViewState extends State<AddCustomerView> {
  AddCustomerController controller = Get.put(AddCustomerController());
  bool isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    double modalSize = !isPortrait
        ? 0.75
        : isKeyboardVisible
            ? 0.8
            : 0.5;
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
                    "Add Customer".toUpperCase(),
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
                child: inputSection(isPortrait),
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
          Constants.showSnackBar(
              context, "SUCCESS", "Customer Added Successfully!");
          Get.back();
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
              "Proceed",
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

  Widget inputSection(bool isPortrait) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 84.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            inputView("Name", controller.nameController),
            const SizedBox(height: 28.0),
            inputView("Tax ID", controller.taxIDController),
            const SizedBox(height: 28.0),
            inputView("Phone Number", controller.phoneNumberController),
            SizedBox(height: isPortrait ? 0.0 : 85.0),
          ],
        ),
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
