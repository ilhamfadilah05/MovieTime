// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/Widget/Container/container.dart';
import '../../Components/Widget/Text/text_stye.dart';
import '../../Controllers/Welcome/splashscreen_controller.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({super.key});

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  final conn = Get.put(SplashscreenController());
  @override
  void initState() {
    conn.cekLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: containerGradient(context, body()));
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo_movietime.png',
          width: 120,
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: textDefault("MovieTime", Colors.white, 40, FontWeight.bold),
        ),
      ],
    );
  }
}
