import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/widgets/custom_dropdown.dart';
import 'package:kedasrd/widgets/custom_tabs_list.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/restaurant/tables_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TablesController controller = Get.find<TablesController>();

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(DummyData.settingItems.length, (index) {
                  var data = DummyData.settingItems[index];
                  return Column(
                    children: [
                      Material(
                        color: Themes.kTransparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(52.0),
                          onTap: () => controller.selectTab(index),
                          child: Obx(
                            () {
                              return Ink(
                                decoration: BoxDecoration(
                                    color: controller.selectedTabIndex.value ==
                                            index
                                        ? Themes.kPrimaryColor
                                        : Themes.kTransparent,
                                    border: Border.all(
                                        color: Themes.kPrimaryColor,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(48.0)),
                                child: Container(
                                  height: 48.0,
                                  width: 48.0,
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    data["icon"],
                                    height: 24.0,
                                    width: 24.0,
                                    color: controller.selectedTabIndex.value ==
                                            index
                                        ? Themes.kWhiteColor
                                        : Themes.kPrimaryColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Obx(
                        () => Text(
                          data["title"],
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: controller.selectedTabIndex.value == index
                                ? Themes.kPrimaryColor
                                : Themes.kGreyColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  Obx(() => buildSelectedView(DummyData
                      .settingTabs[controller.selectedTabIndex.value])),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            submitButton(),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        onTap: () =>
            Constants.showSnackBar(context, "SUCCESS", "Saved Successfully!"),
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

  Widget buildSelectedView(String title) {
    return WidgetAnimator(
      key: ValueKey(title),
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
          delay: const Duration(milliseconds: 150)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: switch (title) {
          "General" => generalView(),
          "Orders" => ordersView(),
          "Kitchen" => kitchenView(),
          "Tables" => tablesView(),
          "Printer" => printerView(),
          _ => taxesView()
        },
      ),
    );
  }

  Widget bodyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: List.generate(DummyData.settingTabs.length, (index) {
          String title = DummyData.settingTabs[index];
          return Obx(() {
            return title == "General"
                ? generalView()
                : title == "Orders"
                    ? ordersView()
                    : title == "Kitchen"
                        ? kitchenView()
                        : title == "Tables"
                            ? tablesView()
                            : title == "Printer"
                                ? printerView()
                                : taxesView();
          });
        }),
      ),
    );
  }

  Widget generalView() {
    return Column(
      children: [
        CustomDropdowns(
            listData: DummyData.bankAccountItems,
            hintText: "Bank Account",
            onChanged: (value) =>
                controller.setDropdownValue('bankAccount', value)),
        const SizedBox(height: 14.0),
        CustomDropdowns(
            listData: DummyData.walletBankAccountItems,
            hintText: "Wallet Bank Account",
            onChanged: (value) =>
                controller.setDropdownValue('walletAccount', value)),
        const SizedBox(height: 14.0),
        CustomDropdowns(
            listData: DummyData.agentsItems,
            hintText: "Select Agent",
            onChanged: (value) =>
                controller.setDropdownValue('selectAgent', value)),
      ],
    );
  }

  Widget ordersView() {
    return Column(
      children: [
        CustomDropdowns(
            listData: DummyData.orderFlowItems,
            hintText: "Order Flow",
            onChanged: (value) =>
                controller.setDropdownValue('orderFlow', value)),
        const SizedBox(height: 14.0),
        CustomDropdowns(
            listData: DummyData.templateItems,
            hintText: "Template",
            onChanged: (value) =>
                controller.setDropdownValue('template', value)),
        const SizedBox(height: 14.0),
        CustomDropdowns(
            listData: DummyData.selectMsgItems,
            hintText: "Select Message",
            onChanged: (value) =>
                controller.setDropdownValue('selectMessage', value)),
        const SizedBox(height: 14.0),
        CustomDropdowns(
            listData: DummyData.templateSelectionItems,
            hintText: "Template Selection",
            onChanged: (value) =>
                controller.setDropdownValue('templateSelection', value)),
      ],
    );
  }

  Widget kitchenView() {
    return Column(
      children: [
        CustomDropdowns(
            listData: DummyData.orderOfShowingItems,
            hintText: "Order of showing",
            onChanged: (value) =>
                controller.setDropdownValue('orderOfShowing', value)),
        const SizedBox(height: 14.0),
        CustomDropdowns(
            listData: DummyData.orderStatusItems,
            hintText: "Order View Status",
            onChanged: (value) =>
                controller.setDropdownValue('orderViewStatus', value)),
      ],
    );
  }

  Widget tablesView() {
    return Column(
      children: [
        CustomDropdowns(
            listData: DummyData.tableModeItems,
            hintText: "Table Mode",
            onChanged: (value) =>
                controller.setDropdownValue('tableMode', value)),
      ],
    );
  }

  Widget printerView() {
    return Column(
      children: [
        CustomDropdowns(
            listData: DummyData.printerItems,
            hintText: "Default Printer",
            onChanged: (value) =>
                controller.setDropdownValue('defaultPrinter', value)),
        const SizedBox(height: 14.0),
        CustomDropdowns(
            listData: DummyData.printerList,
            hintText: "Kitchen Printer",
            onChanged: (value) =>
                controller.setDropdownValue('kitchenPrinter', value)),
        const SizedBox(height: 14.0),
        CustomDropdowns(
            listData: DummyData.printerList,
            hintText: "Bar Printer",
            onChanged: (value) =>
                controller.setDropdownValue('barPrinter', value)),
      ],
    );
  }

  Widget taxesView() {
    return Column(
      children: [
        CustomDropdowns(
            listData: DummyData.tipTaxList,
            hintText: "Tips Tax",
            onChanged: (value) =>
                controller.setDropdownValue('tipsTax', value)),
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
