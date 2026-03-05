import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../presentation/pages/home/home_binding.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/splash/splash_binding.dart';
import '../presentation/pages/splash/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    ),
  ];
}
