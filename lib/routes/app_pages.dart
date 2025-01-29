import 'package:get/get.dart';

import 'package:kedasrd/middleware/auth_middleware.dart';

import 'package:kedasrd/views/auth/sign_in_view.dart';
import 'package:kedasrd/views/auth/entry_log_view.dart';
import 'package:kedasrd/views/auth/upload_photo_view.dart';

import 'package:kedasrd/views/fastfood/fast_food_cart.dart';
import 'package:kedasrd/views/fastfood/fast_food_view.dart';

import 'package:kedasrd/views/home_view.dart';

import 'package:kedasrd/views/notifications_view.dart';

import 'package:kedasrd/views/online_store/info.dart';
import 'package:kedasrd/views/online_store/contact_view.dart';
import 'package:kedasrd/views/online_store/online_store_view.dart';

import 'package:kedasrd/views/pos/pos_view.dart';
import 'package:kedasrd/views/pos/cart_view.dart';

import 'package:kedasrd/views/restaurant/shifts_view.dart';
import 'package:kedasrd/views/restaurant/tables_view.dart';
import 'package:kedasrd/views/restaurant/orders_view.dart';
import 'package:kedasrd/views/restaurant/kitchen_view.dart';
import 'package:kedasrd/views/restaurant/invoice_view.dart';
import 'package:kedasrd/views/restaurant/delivery_view.dart';
import 'package:kedasrd/views/restaurant/new_order_view.dart';
import 'package:kedasrd/views/restaurant/restaurant_view.dart';
import 'package:kedasrd/views/restaurant/all_orders_view.dart';
import 'package:kedasrd/views/super_marker/all_items_view.dart';
import 'package:kedasrd/views/restaurant/active_order_view.dart';
import 'package:kedasrd/views/restaurant/dine_in_order_view.dart';

import 'package:kedasrd/views/settings_view.dart';

import 'package:kedasrd/views/super_marker/keypad_screens_view.dart';
import 'package:kedasrd/views/super_marker/super_market_view.dart';
import 'package:kedasrd/views/super_marker/super_market_cart_view.dart';

part 'app_routes.dart';

class AppPages {
  static String INITIAL = Routes.SIGN_IN;

  static final routes = [
    // Sign In
    GetPage(
      name: Routes.SIGN_IN,
      page: () => const SignInView(),
    ),
    GetPage(
      name: Routes.UPLOAD_PHOTO,
      page: () => const UploadPhotoView(),
    ),
    GetPage(
      name: Routes.ENTRY_LOG,
      page: () => const EntryLogView(),
    ),
    // Home
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      middlewares: [AuthMiddleware()],
    ),
    // POS
    GetPage(
      name: Routes.POS,
      page: () => const POSView(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartView(),
    ),
    // Fast Food
    GetPage(
      name: Routes.FAST_FOOD,
      page: () => const FastFoodView(),
    ),
    GetPage(
      name: Routes.FAST_FOOD_CART,
      page: () => const FastFoodCart(),
      middlewares: [AuthMiddleware()],
    ),
    // Restaurant
    GetPage(
      name: Routes.RESTAURANT,
      page: () => const RestaurantView(),
    ),
    GetPage(
      name: Routes.ACTIVE_ORDER,
      page: () => const ActiveOrderView(),
    ),
    GetPage(
      name: Routes.DELIVERY,
      page: () => const DeliveryView(),
    ),
    GetPage(
      name: Routes.DINE_IN,
      page: () => const DineInOrderView(),
    ),
    GetPage(
      name: Routes.NEW_ORDER,
      page: () => const NewOrderView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.TABLES,
      page: () => const TablesView(),
    ),
    GetPage(
      name: Routes.KITCHEN,
      page: () => const KitchenView(),
    ),
    GetPage(
      name: Routes.ORDERS,
      page: () => const OrdersView(),
    ),
    GetPage(
      name: Routes.ALL_ORDERS,
      page: () => const AllOrdersView(),
    ),
    GetPage(
      name: Routes.SHIFTS,
      page: () => const ShiftsView(),
    ),
    GetPage(
      name: Routes.INVOICE,
      page: () => const InvoiceView(),
    ),
    // Super Market
    GetPage(
      name: Routes.SUPER_MARKET,
      page: () => const SuperMarketView(),
    ),
    GetPage(
      name: Routes.SUPER_MARKET_CART,
      page: () => const SuperMarketCartView(),
    ),
    GetPage(
      name: Routes.ALL_ITEMS,
      page: () => const AllItemsView(),
    ),
    GetPage(
      name: Routes.KEYPAD_SCREENS,
      page: () => const KeypadScreensView(),
    ),
    // Online Store
    GetPage(
      name: Routes.ONLINE_STORE,
      page: () => const OnlineStoreView(),
    ),
    GetPage(
      name: Routes.CONTACT,
      page: () => const ContactView(),
    ),
    GetPage(
      name: Routes.INFO,
      page: () => const Info(),
    ),
    // Settings
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
    ),
    // Notifications
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => const NotificationsView(),
    ),
  ];
}
