import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/custom_text_input.dart';
import 'package:kedasrd/widgets/custom_input_dialog.dart';

import 'package:kedasrd/utils/themes.dart';

class Constants {
  static bool isWindows = Platform.isWindows;
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;

  static String onlineStoreURL =
      "https://portal.kedasrd.com/online-store/210#/online-product";

  static double headerHeight = isIOS ? 52.0 : 64.0;

  static showSnackBar(context, msg) {
    var snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget divider(Size size) {
    return Container(
      height: 0.2,
      width: size.width,
      color: Themes.kGreyColor,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
    );
  }

  static dynamic openPopupMenu(
    BuildContext context,
    TapDownDetails details,
    dynamic data,
    String title,
  ) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(details.globalPosition, details.globalPosition),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position, // Position the menu
      constraints: const BoxConstraints(
        // minWidth: 200, // Minimum width
        maxWidth: 500, // Maximum width
        // minHeight: 500, // Minimum height
        maxHeight: 500, // Maximum height
      ),
      color: Themes.kWhiteColor,
      items: List.generate(data.length, (index) {
        String itemTitle = data[index];
        return PopupMenuItem(
          value: index + 1,
          child: Text(
            itemTitle,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Themes.kBlackColor,
            ),
          ),
        );
      }),
    ).then((value) {
      // if (value != null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Selected: Option $value')),
      //   );
      // }
    });
  }

  static dynamic openDialog({
    required BuildContext context,
    required String title,
    btnText1,
    String? btnText2,
    btnText3,
    double? height,
    Widget? child,
    ScrollPhysics? scroll,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomInputDialog(
        title: title,
        btnText1: btnText1,
        btnText2: btnText2,
        height: height,
        scroll: scroll,
        child: child,
      ),
    );
  }

  static Widget inputSection() {
    return const Column(
      children: [
        CustomTextInput(hintText: "Name", isNumber: false),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "Tax ID", isNumber: true),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "Phone Number", isNumber: true),
      ],
    );
  }
}
