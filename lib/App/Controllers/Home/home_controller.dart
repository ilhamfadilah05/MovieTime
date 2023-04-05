import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Views/Home/movie_all_view.dart';
import 'package:movie_time/App/Views/Home/movie_detail_view.dart';
import 'package:movie_time/App/Views/Home/popular_detail_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Home/poupular_model.dart';

class HomeController extends GetxController {
  var namaLengkap = "".obs;
  var foto = "".obs;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    namaLengkap.value = prefs.getString('namaUser')!;
    foto.value = prefs.getString('fotoUser')!;
  }

  voidTapSeeAll(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("categoryMovie", category);
    Get.offAll(MovieAllView(
      page: "1",
    ));
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

  void tapPopularPeople(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("idPeople", id);
    Get.offAll(PopularDetailView());
  }
}
