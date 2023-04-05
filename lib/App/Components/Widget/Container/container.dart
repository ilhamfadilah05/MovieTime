// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Colors/color.dart';

Widget containerGradient(BuildContext context, Widget body) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: blackGradient)),
    child: body,
  );
}
