import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final bool isNumber, isSecure;
  final bool? isEmail;
  final TextEditingController? controller;
  const CustomTextInput({
    super.key,
    required this.hintText,
    required this.isNumber,
    this.isEmail,
    this.controller,
    this.isSecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      readOnly: hintText.contains("Expire") ? true : false,
      controller: controller,
      obscureText: isSecure,
      keyboardType: isNumber
          ? TextInputType.number
          : (isEmail != null && isEmail == true)
              ? TextInputType.emailAddress
              : TextInputType.text,
      initialValue:
          controller == null ? (hintText == "Amount" ? "\$120.87" : "") : null,
      // style: const TextStyle(
      //   fontSize: 14.0,
      //   fontWeight: FontWeight.w500,
      //   color: Themes.kDarkColor,
      // ),
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
          openDatePicker(context);
        }
      },
    );
  }

  openDatePicker(context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      // var formattedDate = DateFormat("d MMM y").format(picked).toString();
      // if (type == "Date") {
      //   dateController.text = "$picked";
      //   formattedDateController.text = formattedDate;
      // } else {
      //   reminderController.text = "$picked";
      //   formattedReminderController.text = formattedDate;
      // }
    }
  }
}
