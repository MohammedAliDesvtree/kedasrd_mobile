import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/custom_dialog.dart';
import 'package:kedasrd/widgets/custom_text_input.dart';
import 'package:kedasrd/widgets/custom_input_dialog.dart';
import 'package:kedasrd/widgets/custom_bottom_sheet.dart';
import 'package:kedasrd/widgets/custom_bottom_sheet_input.dart';
import 'package:kedasrd/widgets/custom_bottom_sheet_shifts.dart';

import 'package:kedasrd/routes/app_pages.dart';

import 'package:kedasrd/utils/themes.dart';

class Constants {
  static bool isWindows = Platform.isWindows;
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;

  static String onlineStoreURL =
      "https://portal.kedasrd.com/online-store/210#/online-product";

  static double headerHeight = isIOS ? 52.0 : 64.0;

  static String adminUser = "admin@gmail.com";
  static String adminPass = "admin";

  static String otherUser = "other@gmail.com";
  static String otherPass = "other";

  static showSnackBar(context, type, msg) {
    var snackBar = SnackBar(
        content: Text(msg),
        backgroundColor:
            type == "ERROR" ? Themes.kRedColor : Themes.kGreenColor);
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
      // }
    });
  }

  static dynamic openDialog({
    required BuildContext context,
    required String title,
    btnText1,
    String? screen,
    btnText2,
    btnText3,
    double? height,
    Widget? child,
    ScrollPhysics? scroll,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomInputDialog(
        screen: screen,
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

  static dynamic openBottomSheet(
      BuildContext context, String title, List<dynamic> data) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) {
        return CustomBottomSheet(title: title, listData: data);
      },
    );
  }

  static dynamic discardOrder(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomDialog(
        title: 'Discard Order',
        msg: 'Are you sure or want to cancel your cart?',
        positiveAction: () {
          Constants.showSnackBar(context, "SUCCESS", "Order Discarded!");
          Get.back();
        },
      ),
    );
  }

  static dynamic addDiscount(context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) => const CustomBottomSheetInput(
        title: "Add Discount",
        hintText: "Discount",
        btnText1: "Cancel",
        btnText2: "Submit",
      ),
    );
  }

  static dynamic enterCode(context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) => const CustomBottomSheetInput(
        title: "Enter Code to Continue",
        hintText: "Enter Code",
        btnText1: "Submit",
      ),
    );
  }

  static dynamic enterAuthCode({
    required BuildContext context,
    bool? isPortrait,
    required Size size,
    required String screen,
  }) {
    return Constants.openDialog(
      context: context,
      screen: screen,
      title: "Please enter your\nauth code",
      btnText1: "Submit",
      scroll: const AlwaysScrollableScrollPhysics(),
      height: (isPortrait != null && isPortrait) ? size.height / 2.8 : 0,
      child: const CustomTextInput(hintText: "Enter Code here", isNumber: true),
    );
  }

  static dynamic closeShift(context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // To allow full screen dragging
      backgroundColor: Themes.kTransparent,
      builder: (context) => const CustomBottomSheetShifts(
        title: "Close Shift",
        hintText: "Observations",
        btnText1: "Submit",
        btnText2: "Close and Print",
      ),
    );
  }

  static dynamic logout(
      BuildContext context, dynamic authController, String type) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomDialog(
        title: "Confirmation",
        msg: "Are you sure you want to ${type == "Exit" ? "exit" : "logout"} ?",
        positiveAction: () {
          if (type == "Logout") {
            authController.logout();
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        },
      ),
    );
  }
}
