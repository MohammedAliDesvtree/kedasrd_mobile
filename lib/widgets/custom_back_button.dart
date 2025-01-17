import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(44.0),
        onTap: () => Get.back(),
        child: Ink(
          decoration: BoxDecoration(
              color: Themes.kWhiteColor,
              borderRadius: BorderRadius.circular(44.0)),
          child: Container(
            height: 44.0,
            width: 44.0,
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(Images.leftArrow),
          ),
        ),
      ),
    );
  }
}
