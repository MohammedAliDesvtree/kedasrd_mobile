import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/widgets/wrap_list.dart';
import 'package:kedasrd/widgets/custom_drawer.dart';
import 'package:kedasrd/widgets/custom_header.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/dummy_data.dart';

import 'package:kedasrd/controllers/common_controller.dart';
import 'package:kedasrd/controllers/auth/auth_controller.dart';

class NewOrderView extends StatefulWidget {
  const NewOrderView({super.key});

  @override
  State<NewOrderView> createState() => _NewOrderViewState();
}

class _NewOrderViewState extends State<NewOrderView> {
  final GlobalKey<ScaffoldState> newOrderGlobalKey = GlobalKey();
  final CommonController commonController = Get.find<CommonController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: newOrderGlobalKey,
      backgroundColor: Themes.kWhiteColor,
      drawer: CustomDrawer(items: DummyData.restaurantDrawerItems),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomHeader(
                title: "New Order",
                onMenuTapped: () =>
                    newOrderGlobalKey.currentState!.openDrawer()),
            WrapList(
                listData: DummyData.newOrderList,
                onItemTap: (title) => commonController.onNewOrderItemTapped(
                    context, size, isPortrait, title, authController))
          ],
        ),
      ),
    );
  }
}
