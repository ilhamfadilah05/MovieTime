// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Components/Widget/Container/container.dart';
import 'package:movie_time/App/Components/Widget/Container/container_button.dart';
import 'package:movie_time/App/Components/Widget/Text/text_stye.dart';
import 'package:movie_time/App/Controllers/Auth/registrasi_guest_controller.dart';
import 'package:movie_time/App/Views/Welcome/welcome_view.dart';

import '../../Components/Colors/color.dart';

class RegistrasiGuestView extends StatefulWidget {
  const RegistrasiGuestView({super.key});

  @override
  State<RegistrasiGuestView> createState() => _RegistrasiGuestViewState();
}

class _RegistrasiGuestViewState extends State<RegistrasiGuestView> {
  final conn = Get.put(RegistrasiGuestController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(WelcomeView());
        return false;
      },
      child: Scaffold(
        body: Obx(() => containerGradient(context, body())),
      ),
    );
  }

  Widget body() {
    Uint8List image = base64Decode(conn.base64Foto.value);
    return ListView(
      children: [
        textDefault("Daftar Akun Tamu", Colors.white, 20, FontWeight.normal),
        Divider(
          thickness: 1,
          color: Colors.white.withOpacity(0.5),
        ),
        SizedBox(
          height: 50,
        ),
        Column(
          children: [
            image.isEmpty
                ? InkWell(
                    onTap: () => conn.getfoto(context),
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        Icons.add,
                        color: colorGold,
                        size: 30,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () => conn.getfoto(context),
                    child: Container(
                      width: 150,
                      height: 150,
                      // margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textDefault("Tambah Gambar", Colors.white, 14, FontWeight.normal)
          ],
        ),
        SizedBox(
          height: 20,
        ),
        textDefault("Nama Lengkap Anda", Colors.white, 14, FontWeight.normal),
        SizedBox(
          height: 5,
        ),
        formAkun(),
        SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () => conn.onTapLanjut(context),
            child: buttonGradientBlue(context, "Lanjut"))
      ],
    );
  }

  Column formAkun() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            controller: conn.namaLengkap,
            style: TextStyle(
                fontFamily: 'poppins', fontSize: 14, color: Colors.white),
            keyboardType: TextInputType.name,
            onChanged: (value) {
              // conn.onChange(value);
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Nama lengkap",
                hintStyle: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal)),
          ),
        ),
      ],
    );
  }
}
