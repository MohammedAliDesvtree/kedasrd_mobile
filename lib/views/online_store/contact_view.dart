import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/utils/themes.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(title: "Contact Info"),
            customView(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText("Key", "Address"),
                  const SizedBox(height: 6.0),
                  customText("Value",
                      "Calle Padre Bonilla, No. 32 Sector Los Trinitarios, Municipio Santo Domingo Este,Provincia Santo Domingo"),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Text(
                "Opening hours",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Themes.kPrimaryColor,
                ),
              ),
            ),
            customView(
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText("Keys", "Hours"),
                      customText("Value", "Open at - Close at"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText("Keys", "Mon"),
                      customText("Value", "00:00 - 23:59"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText("Keys", "Tue"),
                      customText("Value", "00:00 - 23:59"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText("Keys", "Wed"),
                      customText("Value", "00:00 - 23:59"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText("Keys", "Thu"),
                      customText("Value", "00:00 - 23:59"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText("Keys", "Fri"),
                      customText("Value", "00:00 - 23:59"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText("Keys", "Sat"),
                      customText("Value", "00:00 - 23:59"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customText(String type, String txt) {
    return Text(
      type == "Keys"
          ? txt
          : type == "Key"
              ? "$txt :"
              : txt,
      style: TextStyle(
        fontSize: (type == "Key" || type == "Keys") ? 18.0 : 16.0,
        fontWeight: (type == "Key" || type == "Keys")
            ? FontWeight.w800
            : FontWeight.w500,
        color: (type == "Key" || type == "Keys")
            ? Themes.kPrimaryColor
            : Themes.kBlackColor,
      ),
    );
  }

  Widget customView(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Themes.kGreyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}
