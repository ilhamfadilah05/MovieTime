// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Components/Widget/Container/container.dart';
import 'package:movie_time/App/Components/Widget/Text/text_stye.dart';
import 'package:movie_time/App/Controllers/Home/popular_detail_controller.dart';
import 'package:movie_time/App/Views/Home/home_view.dart';

class PopularDetailView extends StatefulWidget {
  const PopularDetailView({super.key});

  @override
  State<PopularDetailView> createState() => _PopularDetailViewState();
}

class _PopularDetailViewState extends State<PopularDetailView> {
  final conn = Get.put(PopularDetailController());

  @override
  void initState() {
    conn.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(HomeView());
        return false;
      },
      child: Scaffold(
          body: Obx(
        () => containerGradient(context, body()),
      )),
    );
  }

  Widget body() {
    return conn.isLoading.value
        ? PlayStoreShimmer()
        : ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 200,
                        height: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w300${conn.profilePath.value}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      textDefault(
                          conn.name.value, Colors.white, 24, FontWeight.bold),
                      textDefault(conn.departement.value,
                          Colors.white.withOpacity(0.5), 18, FontWeight.bold),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              textDefault("BirthDay :", Colors.white, 20, FontWeight.bold),
              textDefault(conn.birthday.value, Colors.white.withOpacity(0.5),
                  14, FontWeight.bold),
              SizedBox(
                height: 10,
              ),
              textDefault("Biography :", Colors.white, 20, FontWeight.bold),
              textDefault(conn.biography.value, Colors.white.withOpacity(0.5),
                  14, FontWeight.bold)
            ],
          );
  }
}
