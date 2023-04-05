import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Services/Home/home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Views/Home/movie_detail_view.dart';

class SearchMovieController extends GetxController {
  final search = TextEditingController();
  var title = "Search Movies".obs;

  void onChangeText(String value) {
    getSearch(search.text);
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
