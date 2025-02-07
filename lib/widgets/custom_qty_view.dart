import 'package:flutter/material.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';

class CustomQtyView extends StatelessWidget {
  final String screenName;
  final int initialValue;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  const CustomQtyView({
    super.key,
    required this.screenName,
    required this.initialValue,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.0,
      width: 78.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(5.5),
          border: Border.all(width: 0.5, color: Themes.kGreyColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          qtyButton(Images.less, onDecrease),
          Text(
            "$initialValue",
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Themes.kBlackColor,
            ),
          ),
          qtyButton(Images.add, onIncrease),
        ],
      ),
    );
  }
}

Widget qtyButton(String image, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(
      image,
      height: 11.0,
      width: 11.0,
      color: Themes.kPrimaryColor,
    ),
  );
}
