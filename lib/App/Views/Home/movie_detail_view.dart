// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Components/Widget/Container/container.dart';
import 'package:movie_time/App/Components/Widget/Text/text_stye.dart';
import 'package:movie_time/App/Controllers/Home/movie_detail_controller.dart';
import 'package:movie_time/App/Models/Home/poupular_model.dart';

import '../../Models/Home/top_rated_model.dart';
import '../../Services/Home/home_service.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({super.key});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  final conn = Get.put(MovieDetailController());

  @override
  void initState() {
    conn.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          body: Obx(
        () => containerGradient(context, body()),
      )),
    );
  }

  Widget body() {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              width: size.width,
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w300${conn.backdropPath.value}',
                  color: Colors.white.withOpacity(0.5),
                  colorBlendMode: BlendMode.modulate,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 150,
                    margin: EdgeInsets.only(left: 10, top: 170, bottom: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w300${conn.posterPath.value}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 1.7,
                        margin: EdgeInsets.only(left: 10, top: 200, bottom: 5),
                        child: textDefault(conn.title.value, Colors.white, 18,
                            FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          textDefault(conn.voteAverage.value, Colors.white, 14,
                              FontWeight.normal)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        textDefault("Overview :", Colors.white, 20, FontWeight.bold),
        textDefault(conn.overview.value, Colors.white.withOpacity(0.6), 14,
            FontWeight.normal),
        SizedBox(
          height: 10,
        ),
        textDefault("Release date :", Colors.white, 20, FontWeight.bold),
        textDefault(conn.releaseDate.value, Colors.white.withOpacity(0.6), 14,
            FontWeight.normal),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: Colors.white,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textDefault("Popular Movies", Colors.white, 24, FontWeight.normal),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        FutureBuilder<List<PopularModel>>(
            future: getPopular("1"),
            builder: (context, snapshot) {
              List<PopularModel>? listToprated = snapshot.data;

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
      ],
    );
  }
}
