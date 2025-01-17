import 'package:get/get.dart';
import 'package:flutter/material.dart';

class KeypadScreensController extends GetxController {
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
