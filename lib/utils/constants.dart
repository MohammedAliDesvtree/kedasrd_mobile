import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

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
}
