import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';

class CustomSearchBar extends StatelessWidget {
  final bool isEnabled;
  final String title;
  const CustomSearchBar({
    super.key,
    required this.isEnabled,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(),
      child: Container(
        // margin: const EdgeInsets.only(left: 16.0, right: 16.0),
        padding: const EdgeInsets.only(left: 16.0, right: 4.0),
        decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Themes.kBlackColor.withOpacity(0.20),
              blurRadius: 8.0,
              spreadRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: TextFormField(
          enabled: isEnabled,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            border: InputBorder.none,
            hintText: title,
            hintStyle: TextStyle(
              color: Themes.kGreyColor[500],
              fontSize: 14.0,
            ),
            suffixIcon: Container(
              padding: EdgeInsets.symmetric(
                  vertical: isEnabled ? 12.0 : 20.0,
                  horizontal: isEnabled ? 16.0 : 18.0),
              child: Image.asset(
                isEnabled ? Images.search : Images.downFilledArrow,
                height: isEnabled ? 24.0 : 4.0,
                width: isEnabled ? 24.0 : 4.0,
                color: Themes.kGreyColor[500],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
