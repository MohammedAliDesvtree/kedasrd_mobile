import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_dropdown.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/constants.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/super_market/keypad_screens_controller.dart';

class KeypadScreensView extends StatefulWidget {
  const KeypadScreensView({super.key});

  @override
  State<KeypadScreensView> createState() => _KeypadScreensViewState();
}

class _KeypadScreensViewState extends State<KeypadScreensView> {
  var data = Get.arguments;
  final KeypadScreensController controller = Get.put(KeypadScreensController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    String title = data["title"];

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(title: title),
            bodyView(title, size),
          ],
        ),
      ),
    );
  }

  Widget partialBoxView() {
    return Container(
      padding: const EdgeInsets.all(14.0),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomDropdowns(
              listData: DummyData.typeItems, hintText: "Select Type"),
          const SizedBox(height: 14.0),
          CustomDropdowns(
              listData: DummyData.bankAccountItems,
              hintText: "Please Select Account"),
          const SizedBox(height: 14.0),
          const Text(
            "\$60.435",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Themes.kBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentsView() {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Themes.kPrimaryColor)),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Payments",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
          Container(
            height: 48.0,
            padding: const EdgeInsets.all(18.0),
            color: Themes.kPrimaryColor,
            child: Image.asset(
              Images.less,
              color: Themes.kWhiteColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Text(
              "2",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
          Container(
            height: 48.0,
            padding: const EdgeInsets.all(18.0),
            color: Themes.kPrimaryColor,
            child: Image.asset(
              Images.add,
              color: Themes.kWhiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget titleView(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Payment Type : ",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Themes.kPrimaryColor,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Themes.kBlackColor,
          ),
        ),
      ],
    );
  }

  Widget amountView(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$key :",
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Themes.kPrimaryColor,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Themes.kBlackColor,
          ),
        ),
      ],
    );
  }

  Widget bodyView(String title, Size size) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            children: [
              if (title != "Cash") digitsView(title, size),
              if (title.contains("Partial"))
                Column(
                  children: [
                    paymentsView(),
                    const SizedBox(height: 16.0),
                    partialBoxView(),
                    const SizedBox(height: 16.0),
                    partialBoxView(),
                    const SizedBox(height: 16.0),
                  ],
                ),
              if (title.contains("Card"))
                Column(
                  children: [
                    inputView("Card Number"),
                    const SizedBox(height: 14.0),
                    inputView("Expiry Date"),
                    const SizedBox(height: 14.0),
                    CustomDropdowns(
                        listData: DummyData.cardItems,
                        hintText: "Select Card Type"),
                    const SizedBox(height: 14.0),
                  ],
                ),
              if (title == "Cash")
                Column(
                  children: [
                    inputView("Amount"),
                    const SizedBox(height: 14.0),
                  ],
                ),
              CustomDropdowns(
                  listData: DummyData.currencyItems,
                  hintText: "Select Currency"),
              const SizedBox(height: 14.0),
              inputView("Exchange Rate"),
              const SizedBox(height: 14.0),
              CustomDropdowns(
                listData: DummyData.ncfItems,
                hintText: "Select NCF",
              ),
              const SizedBox(height: 14.0),
              CustomDropdowns(
                  listData: DummyData.agentsItems, hintText: "Select Agent"),
              const SizedBox(height: 14.0),
              CustomDropdowns(
                  listData: DummyData.bankAccountItems,
                  hintText: "Please Select Account"),
              const SizedBox(height: 14.0),
              CustomDropdowns(
                  listData: DummyData.taxItems, hintText: "Select Tax"),
              const SizedBox(height: 14.0),
              title != "Receivable"
                  ? inputView("Reference")
                  : inputView("Expire Date"),
              if (title.contains("Partial"))
                Column(
                  children: [
                    const SizedBox(height: 14.0),
                    inputView("Expire Date"),
                  ],
                ),
              const SizedBox(height: 28.0),
              if (title == "Cash")
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(14.0),
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
                      amountView("Total", "\$120.87"),
                      const SizedBox(height: 2.0),
                      amountView("Change", "\$0.00"),
                    ],
                  ),
                ),
              const SizedBox(height: 14.0),
              submitButton(),
              const SizedBox(height: 28.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        onTap: () => Get.back(),
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

  Widget inputView(String hintText) {
    bool isNumber = (hintText == "Amount" ||
        hintText.contains("Rate") ||
        hintText.contains("Number") ||
        hintText.contains("Expiry"));
    return TextFormField(
      autofocus: true,
      readOnly: hintText.contains("Expire") ? true : false,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      initialValue: hintText == "Amount" ? "\$120.87" : "",
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Themes.kBlackColor.withOpacity(0.5))),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Themes.kGreyColor[500],
        ),
      ),
      onTap: () {
        if (hintText.contains("Expire")) {
          controller.openDatePicker(context);
        }
      },
    );
  }

  Widget digitsView(String title, Size size) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 8.0),
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
          if (title == "Cash" ||
              title.contains("Card") ||
              title.contains("Partial"))
            Column(
              children: [
                titleView(title),
                const SizedBox(height: 8.0),
              ],
            ),
          digitsItems(title.contains("Partial") ? "Amount Due" : "Total",
              "DOP \$120.87"),
          if (!title.contains("Card"))
            Column(
              children: [
                Constants.divider(size),
                digitsItems(
                    title.contains("Partial") ? "Partial Total" : "Payment",
                    "DOP \$120.87"),
                Constants.divider(size),
                digitsItems("Balance", "DOP \$0.00"),
              ],
            ),
          Constants.divider(size),
          digitsItems("Client Balance", "DOP \$0.00"),
        ],
      ),
    );
  }

  Widget digitsItems(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$key :",
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Themes.kPrimaryColor,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Themes.kBlackColor,
          ),
        ),
      ],
    );
  }
}
