import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/load_images.dart';

import 'package:kedasrd/views/invoice_view.dart';
import 'package:kedasrd/views/entry_log_view.dart';
import 'package:kedasrd/views/upload_photo_view.dart';

import 'package:kedasrd/views/fastfood/fast_food_cart.dart';

import 'package:kedasrd/views/home_view.dart';
import 'package:kedasrd/views/notifications_view.dart';

import 'package:kedasrd/views/pos/pos_view.dart';
import 'package:kedasrd/views/pos/cart_view.dart';

import 'package:kedasrd/views/settings_view.dart';

import 'package:kedasrd/views/online_store/info.dart';
import 'package:kedasrd/views/online_store/contact_view.dart';
import 'package:kedasrd/views/online_store/online_store_view.dart';

import 'package:kedasrd/views/restaurant/orders_view.dart';
import 'package:kedasrd/views/restaurant/shifts_view.dart';
import 'package:kedasrd/views/restaurant/tables_view.dart';
import 'package:kedasrd/views/restaurant/kitchen_view.dart';
import 'package:kedasrd/views/restaurant/delivery_view.dart';
import 'package:kedasrd/views/restaurant/new_order_view.dart';
import 'package:kedasrd/views/restaurant/all_orders_view.dart';
import 'package:kedasrd/views/restaurant/restaurant_view.dart';
import 'package:kedasrd/views/restaurant/active_order_view.dart';
import 'package:kedasrd/views/restaurant/dine_in_order_view.dart';

import 'package:kedasrd/views/fastfood/fast_food_view.dart';
import 'package:kedasrd/views/super_marker/all_items_view.dart';
import 'package:kedasrd/views/super_marker/keypad_screens_view.dart';

import 'package:kedasrd/views/super_marker/super_market_view.dart';
import 'package:kedasrd/views/super_marker/super_market_cart_view.dart';

import 'package:kedasrd/controllers/common_controller.dart';
import 'package:kedasrd/controllers/drawer_controller.dart';
import 'package:kedasrd/controllers/pos/pos_controller.dart';
import 'package:kedasrd/controllers/pos/cart_controller.dart';
import 'package:kedasrd/controllers/pos/filter_controller.dart';
import 'package:kedasrd/controllers/restaurant/tables_controller.dart';
import 'package:kedasrd/controllers/restaurant/kitchen_controller.dart';
import 'package:kedasrd/controllers/fastfood/fast_food_controller.dart';
import 'package:kedasrd/controllers/restaurant/dine_in_controller.dart';
import 'package:kedasrd/controllers/super_market/super_market_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Themes.kWhiteColor,
      systemNavigationBarColor: Themes.kWhiteColor,
    ),
  );

  await preLoadAllImages();

  Get.put(CommonController());
  Get.put(CartController());
  Get.put(POSController());
  Get.put(FastFoodController());
  Get.put(FilterController());
  Get.put(SuperMarketController());
  Get.put(DineInController());
  Get.put(TablesController());
  Get.put(KitchenController());
  Get.put(DrawerMenuController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kedasrd',
        theme: ThemeData(
            fontFamily: "Outfit",
            colorScheme: ColorScheme.fromSeed(seedColor: Themes.kPrimaryColor),
            useMaterial3: true),
        initialRoute: '/home',
        getPages: [
          // Home
          GetPage(name: '/home', page: () => const HomeView()),
          // POS
          GetPage(name: '/pos', page: () => const POSView()),
          GetPage(name: '/cart', page: () => const CartView()),
          // Fast Food
          GetPage(name: '/fastFood', page: () => const FastFoodView()),
          GetPage(name: '/fast_food_cart', page: () => const FastFoodCart()),
          // Restaurant
          GetPage(name: '/restaurant', page: () => const RestaurantView()),
          GetPage(name: '/active_order', page: () => const ActiveOrderView()),
          GetPage(name: '/delivery', page: () => const DeliveryView()),
          GetPage(name: '/dine_in', page: () => const DineInOrderView()),
          GetPage(name: '/new_order', page: () => const NewOrderView()),
          GetPage(name: '/tables', page: () => const TablesView()),
          GetPage(name: '/kitchen', page: () => const KitchenView()),
          GetPage(name: '/orders', page: () => const OrdersView()),
          GetPage(name: '/all_orders', page: () => const AllOrdersView()),
          GetPage(name: '/shifts', page: () => const ShiftsView()),
          // Super Market
          GetPage(name: '/super_market', page: () => const SuperMarketView()),
          GetPage(
              name: '/super_market_cart',
              page: () => const SuperMarketCartView()),
          GetPage(name: '/all_items', page: () => const AllItemsView()),
          GetPage(
              name: '/keypad_screens', page: () => const KeypadScreensView()),
          // Online Store
          GetPage(name: '/onlineStore', page: () => const OnlineStoreView()),
          GetPage(name: '/contact', page: () => const ContactView()),
          GetPage(name: '/info', page: () => const Info()),
          // Settings
          GetPage(name: '/settings', page: () => const SettingsView()),
          // Notifications
          GetPage(
              name: '/notifications', page: () => const NotificationsView()),

          GetPage(name: '/upload_photo', page: () => const UploadPhotoView()),
          GetPage(name: '/entry_log', page: () => const EntryLogView()),
          GetPage(name: '/invoice', page: () => const InvoiceView()),
        ]);
  }
}
