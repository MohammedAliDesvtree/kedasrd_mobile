import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_dropdown.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Initial Selected Value
  String dropdownValue = 'Item 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customHeader(),
            Expanded(
              child: ListView(
                children: [
                  bodyView(),
                  const Spacer(),
                  const SizedBox(height: 28.0),
                ],
              ),
            ),
            submitButton(),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        onTap: () => Constants.showSnackBar(context, "Saved Successfully!"),
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

  Widget bodyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          CustomDropdowns(listData: DummyData.ncfItems, hintText: "NCF"),
          const SizedBox(height: 14.0),
          CustomDropdowns(
              listData: DummyData.bankAccountItems, hintText: "Bank Account"),
          const SizedBox(height: 14.0),
          CustomDropdowns(
              listData: DummyData.walletBankAccountItems,
              hintText: "Wallet Bank Account"),
          const SizedBox(height: 14.0),
          CustomDropdowns(
              listData: DummyData.templateItems, hintText: "Template"),
          const SizedBox(height: 14.0),
          CustomDropdowns(
              listData: DummyData.templateSelectionItems,
              hintText: "Template Selection"),
          const SizedBox(height: 14.0),
          CustomDropdowns(
              listData: DummyData.printerItems, hintText: "Default Printer"),
          const SizedBox(height: 14.0),
          CustomDropdowns(
              listData: DummyData.orderOfShowingItems,
              hintText: "Order of showing"),
        ],
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
            const Expanded(
              child: Text(
                "Setting",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Themes.kBlackColor,
                ),
              ),
            ),
            const SizedBox(width: 20.0),
          ],
        ),
      ),
    );
  }
}
