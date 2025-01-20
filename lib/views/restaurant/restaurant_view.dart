import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/widgets/wrap_list.dart';
import 'package:kedasrd/widgets/custom_header.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';

import 'package:kedasrd/controllers/common_controller.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({super.key});

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  final GlobalKey<ScaffoldState> restaurantGlobalKey = GlobalKey();
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: restaurantGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "Restaurant",
                onMenuTapped: () =>
                    restaurantGlobalKey.currentState!.openDrawer()),
            WrapList(
                listData: DummyData.restaurantList,
                onItemTap: (title) =>
                    commonController.onRestaurantItemTapped(title)),
          ],
        ),
      ),
    );
  }
}
