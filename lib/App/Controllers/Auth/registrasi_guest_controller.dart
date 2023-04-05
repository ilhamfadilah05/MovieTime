// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_time/App/Components/Alert/alert.dart';
import 'package:movie_time/App/Views/Home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrasiGuestController extends GetxController {
  final namaLengkap = TextEditingController();
  var base64Foto = "".obs;

  onTapLanjut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (base64Foto.value == "") {
      alertError(context, "Harus ada foto !");
    } else if (namaLengkap.text == "") {
      alertError(context, "Nama harus di isi !");
    } else {
      prefs.setString("namaUser", namaLengkap.text);
      prefs.setString("fotoUser", base64Foto.value);

      prefs.setString("tokenApp", namaLengkap.text);

      Get.offAll(HomeView());
    }
  }

  Future getfoto(BuildContext context) async {
    File? _image;
    dynamic bytes;
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    _image = File(imagePicked!.path);
    bytes = File(imagePicked.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    base64Foto.value = img64;
  }
}
