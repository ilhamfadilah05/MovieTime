// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Components/Colors/color.dart';
import 'package:movie_time/App/Components/Widget/Container/container.dart';
import 'package:movie_time/App/Components/Widget/Text/text_stye.dart';
import 'package:movie_time/App/Controllers/Home/home_controller.dart';
import 'package:movie_time/App/Models/Home/now_playing_model.dart';
import 'package:movie_time/App/Models/Home/popular_people_model.dart';
import 'package:movie_time/App/Models/Home/poupular_model.dart';
import 'package:movie_time/App/Models/Home/top_rated_model.dart';
import 'package:movie_time/App/Models/Home/upcoming_model.dart';
import 'package:movie_time/App/Services/Home/home_service.dart';
import 'package:movie_time/App/Views/Home/search_movie_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Components/Widget/image_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final conn = Get.put(HomeController());
  @override
  void initState() {
    conn.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => containerGradient(context, body())),
    );
  }

  Widget body() {
    Uint8List image = base64Decode(conn.foto.value);

    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textDefault("Selamat Datang, ", Colors.white, 24,
                        FontWeight.normal),
                    textDefault(conn.namaLengkap.value, Colors.white, 17,
                        FontWeight.normal),
                  ],
                )
              ],
            ),
            image.isEmpty
                ? Container()
                : InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.memory(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () => Get.offAll(SearchMovieView()),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.5),
                ),
                SizedBox(
                  width: 20,
                ),
                textDefault("Search movie", Colors.white.withOpacity(0.5), 18,
                    FontWeight.normal)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textDefault("Popular Movies", Colors.white, 24, FontWeight.normal),
            InkWell(
              onTap: () {
                conn.voidTapSeeAll("Popular");
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.5))),
                child:
                    textDefault("See All", Colors.white, 14, FontWeight.normal),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder<List<PopularModel>>(
            future: getPopular("1"),
            builder: (context, snapshot) {
              List<PopularModel>? listToprated = snapshot.data;
              List<String> listImage = [];

              for (var a = 0; a < 10; a++) {
                (listToprated == null)
                    ? null
                    : listImage.add(
                        "https://image.tmdb.org/t/p/w300${listToprated[a].posterPath!}");
              }
              if (snapshot.hasData) {
                return listToprated == null
                    ? Container()
                    : InkWell(
                        onTap: () {
                          for (var b = 0; b < 10; b++) {
                            conn.tapMovie(
                                context,
                                listToprated[b].title!,
                                listToprated[b].backdropPath!,
                                listToprated[b].id!,
                                listToprated[b].overview!,
                                listToprated[b].posterPath!,
                                "${listToprated[b].voteAverage!}",
                                "${listToprated[b].voteCount!}",
                                listToprated[b].releaseDate!);
                          }
                        },
                        child: FanCarouselImageSlider(
                          isClickable: false,
                          sliderHeight: 400,
                          imagesLink: listImage,
                          isAssets: false,
                          autoPlay: true,
                        ),
                      );
              } else if (snapshot.hasError) {
                return PlayStoreShimmer();
              }
              return PlayStoreShimmer();
            }),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textDefault(
                "Now Playing Movies", Colors.white, 24, FontWeight.normal),
            InkWell(
              onTap: () => conn.voidTapSeeAll("Now Playing"),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.5))),
                child:
                    textDefault("See All", Colors.white, 14, FontWeight.normal),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        FutureBuilder<List<NowPlayingModel>>(
            future: getNowPlaying("1"),
            builder: (context, snapshot) {
              List<NowPlayingModel>? listToprated = snapshot.data;

              if (snapshot.hasData) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      reverse: true,
                      autoPlay: true,
                      aspectRatio: 2.0,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: listToprated!
                        .map(
                          (item) => Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  conn.tapMovie(
                                      context,
                                      item.title!,
                                      item.backdropPath!,
                                      item.id!,
                                      item.overview!,
                                      item.posterPath!,
                                      "${item.voteAverage!}",
                                      "${item.voteCount!}",
                                      item.releaseDate!);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 500,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/w300${item.backdropPath!}",
                                      color: Colors.white.withOpacity(0.5),
                                      colorBlendMode: BlendMode.modulate,
                                      height: 400,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    padding: EdgeInsets.all(2),
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        textDefault("${item.voteAverage!}",
                                            Colors.white, 14, FontWeight.normal)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        textDefault(item.title!, Colors.white,
                                            20, FontWeight.bold),
                                        Text(
                                          item.overview!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 12,
                                              color: Colors.white
                                                  .withOpacity(0.8)),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )
                        .toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                return PlayStoreShimmer();
              }
              return PlayStoreShimmer();
            }),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textDefault(
                "Top Rated Movies", Colors.white, 24, FontWeight.normal),
            InkWell(
              onTap: () => conn.voidTapSeeAll("Top Rated"),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.5))),
                child:
                    textDefault("See All", Colors.white, 14, FontWeight.normal),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        FutureBuilder<List<TopRatedModel>>(
            future: getTopRated("1"),
            builder: (context, snapshot) {
              List<TopRatedModel>? listToprated = snapshot.data;

              if (snapshot.hasData) {
                return Container(
                  height: 200,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: listToprated!.length,
                      itemBuilder: (context, i) {
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                conn.tapMovie(
                                    context,
                                    listToprated[i].title!,
                                    listToprated[i].backdropPath!,
                                    listToprated[i].id!,
                                    listToprated[i].overview!,
                                    listToprated[i].posterPath!,
                                    "${listToprated[i].voteAverage!}",
                                    "${listToprated[i].voteCount!}",
                                    listToprated[i].releaseDate!);
                              },
                              child: Container(
                                width: 150,
                                height: 200,
                                margin: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w300${listToprated[i].posterPath!}",
                                    fit: BoxFit.cover,
                                    color: Colors.white.withOpacity(0.8),
                                    colorBlendMode: BlendMode.modulate,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      textDefault(
                                          "${listToprated[i].voteAverage!}",
                                          Colors.white,
                                          14,
                                          FontWeight.normal)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return PlayStoreShimmer();
              }
              return PlayStoreShimmer();
            }),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textDefault("Upcoming Movies", Colors.white, 24, FontWeight.normal),
            InkWell(
              onTap: () => conn.voidTapSeeAll("Upcoming"),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.5))),
                child:
                    textDefault("See All", Colors.white, 14, FontWeight.normal),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        FutureBuilder<List<UpcomingModel>>(
            future: getUpcoming("1"),
            builder: (context, snapshot) {
              List<UpcomingModel>? listToprated = snapshot.data;

              if (snapshot.hasData) {
                return Container(
                  height: 200,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: listToprated!.length,
                      itemBuilder: (context, i) {
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                conn.tapMovie(
                                    context,
                                    listToprated[i].title!,
                                    listToprated[i].backdropPath!,
                                    listToprated[i].id!,
                                    listToprated[i].overview!,
                                    listToprated[i].posterPath!,
                                    "${listToprated[i].voteAverage!}",
                                    "${listToprated[i].voteCount!}",
                                    listToprated[i].releaseDate!);
                              },
                              child: Container(
                                width: 150,
                                height: 200,
                                margin: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w300${listToprated[i].posterPath!}",
                                    fit: BoxFit.cover,
                                    color: Colors.white.withOpacity(0.8),
                                    colorBlendMode: BlendMode.modulate,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      textDefault(
                                          "${listToprated[i].voteAverage!}",
                                          Colors.white,
                                          14,
                                          FontWeight.normal)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return PlayStoreShimmer();
              }
              return PlayStoreShimmer();
            }),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textDefault("Popular People", Colors.white, 24, FontWeight.normal),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        FutureBuilder<List<PopularPeopleModel>>(
            future: getPopularPeople("1"),
            builder: (context, snapshot) {
              List<PopularPeopleModel>? listToprated = snapshot.data;

              if (snapshot.hasData) {
                return Container(
                  height: 180,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            conn.tapPopularPeople("${listToprated[i].id}");
                            print(listToprated[i].id);
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.5))),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 140,
                                  // margin: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/w300${listToprated![i].profilePath!}",
                                      fit: BoxFit.fill,
                                      color: Colors.white.withOpacity(0.8),
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  ),
                                ),
                                textDefault(listToprated[i].name!, Colors.white,
                                    14, FontWeight.normal)
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return PlayStoreShimmer();
              }
              return PlayStoreShimmer();
            }),
      ],
    );
  }
}
