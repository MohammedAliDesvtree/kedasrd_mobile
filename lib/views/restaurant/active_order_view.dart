import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/wrap_list.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/common_controller.dart';

class ActiveOrderView extends StatefulWidget {
  const ActiveOrderView({super.key});

  @override
  State<ActiveOrderView> createState() => _ActiveOrderViewState();
}

class _ActiveOrderViewState extends State<ActiveOrderView> {
  final GlobalKey<ScaffoldState> activeOrderGlobalKey = GlobalKey();
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: activeOrderGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "Active Order",
                onMenuTapped: () =>
                    activeOrderGlobalKey.currentState!.openDrawer()),
            WrapList(
                listData: DummyData.activeOrderList,
                onItemTap: (title) =>
                    commonController.onActiveOrderItemTapped(title))
          ],
        ),
      ),
    );
  }
}
