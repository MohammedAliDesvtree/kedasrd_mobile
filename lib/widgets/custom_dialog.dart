import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';

class CustomDialog extends StatelessWidget {
  final String title, msg;
  final String? positiveBtn, negativeBtn;
  final dynamic positiveAction;
  const CustomDialog({
    super.key,
    required this.title,
    this.positiveBtn,
    this.negativeBtn,
    required this.msg,
    required this.positiveAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Themes.kBlackColor,
        ),
      ),
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: Themes.kBlackColor,
        ),
      ),
      actions: <Widget>[
        dialogButton(negativeBtn ?? "No"),
        dialogButton(positiveBtn ?? "Yes"),
      ],
    );
  }

  Widget dialogButton(String title) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40.0),
        onTap: () {
          if (title == "Yes" || title == positiveBtn) {
            positiveAction();
          } else {
            Get.back();
          }
        },
        child: Ink(
          decoration: BoxDecoration(
              color: (title == "Yes" || title == positiveBtn)
                  ? Themes.kPrimaryColor
                  : Themes.kPrimaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(40.0)),
          child: Container(
            height: 40.0,
            width: 100.0,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
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
}
