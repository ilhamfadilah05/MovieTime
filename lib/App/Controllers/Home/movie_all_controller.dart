// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Views/Home/movie_all_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Components/Widget/Text/text_stye.dart';
import '../../Views/Home/movie_detail_view.dart';

class MovieAllController extends GetxController {
  var categoryMovie = "".obs;
  List<Widget> listPage = [];

  void getData(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    categoryMovie.value = prefs.getString('categoryMovie')!;
    for (var a = 1; a <= 5; a++) {
      listPage.add(
        InkWell(
          onTap: () {
            page = "$a";
            Get.offAll(MovieAllView(
              page: "${page}",
            ));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(page != "$a" ? 0.5 : 0.1),
                borderRadius: BorderRadius.circular(10)),
            child: textDefault("$a", Colors.white, 14, FontWeight.normal),
          ),
        ),
      );
    }
  }

  void tapMovie(
      BuildContext context,
      String title,
      String backDropPath,
      int id,
      String overview,
      String posterPath,
      String voteAverage,
      String voteCount,
      String releaseDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('titleMovie', title);
    prefs.setString('backdropPathMovie', backDropPath);
    prefs.setInt('idMovie', id);
    prefs.setString('overviewMovie', overview);
    prefs.setString('posterPathMovie', posterPath);
    prefs.setString('voteAverageMovie', voteAverage);
    prefs.setString('voteCountMovie', voteCount);
    prefs.setString('releaseDateMovie', releaseDate);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetailView();
    }));
  }
}
