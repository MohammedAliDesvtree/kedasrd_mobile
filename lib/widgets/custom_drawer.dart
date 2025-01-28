import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/controllers/drawer_controller.dart';

class CustomDrawer extends StatefulWidget {
  final List<dynamic> items;
  final String? screenName;
  const CustomDrawer({
    super.key,
    required this.items,
    this.screenName,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.of(context).size;

    return Drawer(
      width: Get.width / 1.9,
      backgroundColor: Themes.kPrimaryColor,
      child: SafeArea(
        child: Column(
          children: [
            // Image.asset(Images.kedasLogo, height: 84.0),
            widget.screenName != "Online Store"
                ? Column(
                    children: [
                      const SizedBox(height: 24.0),
                      Material(
                        color: Themes.kTransparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () => controller.onCloseShiftTapped(
                              context, size, isPortrait),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Themes.kWhiteColor,
                                borderRadius: BorderRadius.circular(42.0)),
                            child: Container(
                              height: 42.0,
                              width: Get.width / 3,
                              alignment: Alignment.center,
                              child: const Text(
                                "Close Shift",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Themes.kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "s ID : 00123",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(widget.items.length, (index) {
                    var data = widget.items[index];
                    return Material(
                      color: Themes.kTransparent,
                      child: InkWell(
                        onTap: () => controller.onMenuItemTapped(
                            data["title"], index, context),
                        child: Ink(
                          child: Container(
                            color: controller.selectedIndex == index
                                ? Themes.kWhiteColor.withOpacity(0.2)
                                : Themes.kTransparent,
                            padding: const EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 24.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  data["icon"],
                                  height: 20.0,
                                  color: Themes.kWhiteColor,
                                ),
                                const SizedBox(width: 16.0),
                                Text(
                                  data["title"],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Themes.kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
