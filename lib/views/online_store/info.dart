import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_dropdown.dart';

import 'package:kedasrd/views/online_store/payment_info_view.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      bottomNavigationBar: SafeArea(child: submitButton()),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const CustomHeader(title: "Add Address"),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // CustomDropdowns(
                      //     listData: DummyData.countryItems,
                      //     hintText: "Select Country"),
                      // const SizedBox(height: 14.0),
                      inputView("Full Name"),
                      const SizedBox(height: 14.0),
                      inputView("Mobile Number"),
                      const SizedBox(height: 14.0),
                      inputView(
                          "Flat, House No., Building, Company, Apartment"),
                      const SizedBox(height: 14.0),
                      inputView("Area, Street, Sector, Village"),
                      const SizedBox(height: 14.0),
                      inputView("Landmark (Optional)"),
                      const SizedBox(height: 14.0),
                      // CustomDropdowns(
                      //     listData: DummyData.stateItems,
                      //     hintText: "Select State"),
                      // const SizedBox(height: 14.0),
                      inputView("Town/City"),
                      const SizedBox(height: 14.0),
                      inputView("Pincode"),
                      const SizedBox(height: 14.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputView(String hintText) {
    bool isNumber = hintText == "Pincode" || hintText.contains("Number");
    return TextFormField(
      autofocus: true,
      // readOnly: hintText.contains("Expire") ? true : false,
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
      // onTap: () {
      //   if (hintText.contains("Expire")) {
      //     controller.openDatePicker(context);
      //   }
      // },
    );
  }

  Widget submitButton() {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () => showModalBottomSheet(
          context: context,
          isDismissible: false,
          enableDrag: false,
          isScrollControlled: true, // To allow full screen dragging
          backgroundColor: Themes.kTransparent,
          builder: (context) {
            return const PaymentInfoView();
          },
        ),
        child: Ink(
          decoration: const BoxDecoration(
            color: Themes.kPrimaryColor,
            // borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            height: 54.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "2 Items",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Themes.kWhiteColor,
                  ),
                ),
                const Text(
                  "Pay \$1024.32",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Themes.kWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
