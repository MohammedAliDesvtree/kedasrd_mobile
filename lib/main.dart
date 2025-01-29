import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:kedasrd/routes/app_pages.dart';
import 'package:kedasrd/routes/app_bindings.dart';

import 'package:kedasrd/utils/themes.dart';
import 'package:kedasrd/utils/load_images.dart';

import 'package:kedasrd/controllers/auth/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Themes.kWhiteColor,
      systemNavigationBarColor: Themes.kWhiteColor,
    ),
  );

  await preLoadAllImages();
  await GetStorage.init();

  // Initialize AuthController first
  Get.put(AuthController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final initialRoute =
        authController.checkLoginStatus() ? Routes.HOME : Routes.SIGN_IN;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kedasrd',
      theme: ThemeData(
          fontFamily: "Outfit",
          colorScheme: ColorScheme.fromSeed(seedColor: Themes.kPrimaryColor),
          useMaterial3: true),
      initialBinding: AppBindings(), // Add this line to use your bindings
      initialRoute:
          initialRoute, // Start with SIGN_IN instead of dynamic INITIAL
      getPages: AppPages.routes,
    );
  }
}
