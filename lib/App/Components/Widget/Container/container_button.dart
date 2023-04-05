// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_time/App/Components/Colors/color.dart';

import '../Text/text_stye.dart';

Widget buttonGradientBlue(BuildContext context, String nameButton) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: buttonGradient),
        borderRadius: BorderRadius.circular(5)),
    child: Center(
      child: textDefault(nameButton, Colors.white, 16, FontWeight.normal),
    ),
  );
}
