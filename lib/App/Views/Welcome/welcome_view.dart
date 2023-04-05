// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Components/Widget/Container/container.dart';
import 'package:movie_time/App/Components/Widget/Container/container_button.dart';
import 'package:movie_time/App/Views/Auth/registrasi_guest_view.dart';

import '../../Components/Widget/Text/text_stye.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: containerGradient(context, body()),
    );
  }

  Widget body() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo_movietime.png',
                  width: 150,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(),
              textDefault(
                  "Selamat Datang,", Colors.white, 20, FontWeight.normal),
              textDefault("di Aplikasi Movie Time", Colors.white, 30,
                  FontWeight.normal),
            ],
          ),
          InkWell(
              onTap: () => Get.offAll(RegistrasiGuestView()),
              child: buttonGradientBlue(context, "Lanjut")),
        ],
      ),
    );
  }
}
