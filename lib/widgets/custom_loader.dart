import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:kedasrd/utils/themes.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: Center(
        child: Lottie.asset(
          'lib/assets/loaders/loader.json',
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
