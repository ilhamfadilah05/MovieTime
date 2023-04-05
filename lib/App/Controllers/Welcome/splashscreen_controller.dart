import 'dart:async';

import 'package:get/get.dart';
import 'package:movie_time/App/Views/Home/home_view.dart';
import 'package:movie_time/App/Views/Welcome/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenController extends GetxController {
  void cekLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('tokenApp');
    if (stringValue == null) {
      Timer(const Duration(seconds: 1), () => Get.offAll(const WelcomeView()));
    } else {
      Timer(const Duration(seconds: 1), () => Get.offAll(const HomeView()));
    }
  }
}
