// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:movie_time/App/Models/Home/now_playing_model.dart';
import 'package:movie_time/App/Models/Home/top_rated_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Models/Home/popular_people_model.dart';
import '../../Models/Home/poupular_model.dart';
import '../../Models/Home/search_model.dart';
import '../../Models/Home/upcoming_model.dart';

Future<List<TopRatedModel>> getTopRated(String page) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=d6d6da69c088ce5c38ae7a00582ad1c4&language=en-US&page=' +
              page));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  final dataa = json.decode(responseString);
  List jsonResponse = dataa['results'];
  if (response.statusCode == 200) {
    return jsonResponse.map((data) => TopRatedModel.fromJson(data)).toList();
  } else {
    print(response.reasonPhrase);
  }

  return jsonResponse.map((data) => TopRatedModel.fromJson(data)).toList();
}

Future<List<PopularModel>> getPopular(String page) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=d6d6da69c088ce5c38ae7a00582ad1c4&language=en-US&page=' +
              page));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  final dataa = json.decode(responseString);
  List jsonResponse = dataa['results'];
  if (response.statusCode == 200) {
    return jsonResponse.map((data) => PopularModel.fromJson(data)).toList();
  } else {
    print(response.reasonPhrase);
  }

  return jsonResponse.map((data) => PopularModel.fromJson(data)).toList();
}

Future<List<UpcomingModel>> getUpcoming(String page) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=d6d6da69c088ce5c38ae7a00582ad1c4&language=en-US&page=' +
              page));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  final dataa = json.decode(responseString);
  List jsonResponse = dataa['results'];
  if (response.statusCode == 200) {
    return jsonResponse.map((data) => UpcomingModel.fromJson(data)).toList();
  } else {
    print(response.reasonPhrase);
  }

  return jsonResponse.map((data) => UpcomingModel.fromJson(data)).toList();
}

Future<List<NowPlayingModel>> getNowPlaying(String page) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=d6d6da69c088ce5c38ae7a00582ad1c4&language=en-US&page=' +
              page));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  final dataa = json.decode(responseString);
  List jsonResponse = dataa['results'];
  if (response.statusCode == 200) {
    return jsonResponse.map((data) => NowPlayingModel.fromJson(data)).toList();
  } else {
    print(response.reasonPhrase);
  }

  return jsonResponse.map((data) => NowPlayingModel.fromJson(data)).toList();
}

Future<List<SearchModel>> getSearch(String query) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=d6d6da69c088ce5c38ae7a00582ad1c4&language=en-US&page=1&include_adult=false&query=' +
              query));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  final dataa = json.decode(responseString);
  List jsonResponse = dataa['results'];
  if (response.statusCode == 200) {
    return jsonResponse.map((data) => SearchModel.fromJson(data)).toList();
  } else {
    print(response.reasonPhrase);
  }

  return jsonResponse.map((data) => SearchModel.fromJson(data)).toList();
}

Future<List<PopularPeopleModel>> getPopularPeople(String page) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.themoviedb.org/3/person/popular?api_key=d6d6da69c088ce5c38ae7a00582ad1c4&language=en-US&page=' +
              page));

  http.StreamedResponse response = await request.send();
  var responseString = await response.stream.bytesToString();
  final dataa = json.decode(responseString);
  List jsonResponse = dataa['results'];
  if (response.statusCode == 200) {
    return jsonResponse
        .map((data) => PopularPeopleModel.fromJson(data))
        .toList();
  } else {
    print(response.reasonPhrase);
  }

  return jsonResponse.map((data) => PopularPeopleModel.fromJson(data)).toList();
}
