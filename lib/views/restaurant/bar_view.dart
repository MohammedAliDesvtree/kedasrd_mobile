import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

class BarView extends StatefulWidget {
  const BarView({super.key});

  @override
  State<BarView> createState() => _BarViewState();
}

class _BarViewState extends State<BarView> {
  final GlobalKey<ScaffoldState> barGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: barGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "Bar",
                onMenuTapped: () => barGlobalKey.currentState!.openDrawer()),
            const SizedBox(height: 16.0),
            const SizedBox(height: 64.0),
            const Text(
              "No result found",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Themes.kBlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
