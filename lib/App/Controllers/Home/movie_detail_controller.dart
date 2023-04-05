import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Views/Home/movie_detail_view.dart';

class MovieDetailController extends GetxController {
  var date = DateTime.now().obs;
  var title = "".obs;
  var backdropPath = "".obs;
  var id = 0.obs;
  var overview = "".obs;
  var posterPath = "".obs;
  var voteAverage = "".obs;
  var voteCount = "".obs;
  var releaseDate = "".obs;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    title.value = prefs.getString('titleMovie')!;
    backdropPath.value = prefs.getString('backdropPathMovie')!;
    id.value = prefs.getInt('idMovie')!;
    overview.value = prefs.getString('overviewMovie')!;
    posterPath.value = prefs.getString('posterPathMovie')!;
    voteAverage.value = prefs.getString('voteAverageMovie')!;
    voteCount.value = prefs.getString('voteCountMovie')!;
    releaseDate.value = prefs.getString('releaseDateMovie')!;
    date.value = DateTime.parse(releaseDate.value);
    releaseDate.value =
        DateFormat("dd MMMM yyyy").format(date.value).toString();
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
