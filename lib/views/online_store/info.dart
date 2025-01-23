import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';
// import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_text_input.dart';
// import 'package:kedasrd/widgets/custom_dropdown.dart';

import 'package:kedasrd/views/online_store/payment_info_view.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

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
                child: Container(
                  height: size.height / 2.5,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // CustomDropdowns(
                      //     listData: DummyData.countryItems,
                      //     hintText: "Select Country"),
                      // const SizedBox(height: 14.0),
                      isPortrait
                          ? const Column(
                              children: [
                                CustomTextInput(
                                    hintText: "Name", isNumber: false),
                                CustomTextInput(
                                    hintText: "Phone Number", isNumber: true),
                                CustomTextInput(
                                    hintText: "Email Address", isNumber: false),
                                CustomTextInput(
                                    hintText: "Address", isNumber: false),
                              ],
                            )
                          : const Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                        child: CustomTextInput(
                                            hintText: "Name", isNumber: false)),
                                    const SizedBox(width: 14.0),
                                    const Expanded(
                                        child: CustomTextInput(
                                            hintText: "Phone Number",
                                            isNumber: true)),
                                  ],
                                ),
                                const SizedBox(height: 14.0),
                                Row(
                                  children: [
                                    const Expanded(
                                        child: CustomTextInput(
                                            hintText: "Email Address",
                                            isNumber: false)),
                                    const SizedBox(width: 14.0),
                                    const Expanded(
                                        child: CustomTextInput(
                                            hintText: "Address",
                                            isNumber: false)),
                                  ],
                                ),
                                const SizedBox(height: 14.0),
                              ],
                            ),

                      // inputView("Phone Number"),
                      // const SizedBox(height: 14.0),
                      // inputView("Email Address"),
                      // const SizedBox(height: 14.0),
                      // inputView("Address"),
                      // const SizedBox(height: 14.0),
                      // inputView("Landmark (Optional)"),
                      // const SizedBox(height: 14.0),
                      // CustomDropdowns(
                      //     listData: DummyData.stateItems,
                      //     hintText: "Select State"),
                      // const SizedBox(height: 14.0),
                      // inputView("Town/City"),
                      // const SizedBox(height: 14.0),
                      // inputView("Pincode"),
                      // const SizedBox(height: 14.0),
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
            child: const Text(
              "Submit Order Now",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Themes.kWhiteColor,
              ),
            ),
            // child: const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "2 Items",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.w700,
            //         color: Themes.kWhiteColor,
            //       ),
            //     ),
            //     Text(
            //       "Pay \$1024.32",
            //       style: TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.w700,
            //         color: Themes.kWhiteColor,
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
