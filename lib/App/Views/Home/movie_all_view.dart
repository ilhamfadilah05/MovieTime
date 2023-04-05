// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Components/Widget/Container/container.dart';
import 'package:movie_time/App/Components/Widget/Text/text_stye.dart';
import 'package:movie_time/App/Controllers/Home/movie_all_controller.dart';
import 'package:movie_time/App/Models/Home/now_playing_model.dart';
import 'package:movie_time/App/Models/Home/poupular_model.dart';
import 'package:movie_time/App/Models/Home/top_rated_model.dart';
import 'package:movie_time/App/Models/Home/upcoming_model.dart';
import 'package:movie_time/App/Services/Home/home_service.dart';
import 'package:movie_time/App/Views/Home/home_view.dart';

class MovieAllView extends StatefulWidget {
  String page;
  MovieAllView({required this.page, super.key});

  @override
  State<MovieAllView> createState() => _MovieAllViewState();
}

class _MovieAllViewState extends State<MovieAllView> {
  final conn = Get.put(MovieAllController());
  @override
  void initState() {
    conn.getData(widget.page);
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
    return ListView(
      children: [
        textDefault(conn.categoryMovie.value + " Movies", Colors.white, 22,
            FontWeight.bold),
        SizedBox(
          height: 10,
        ),
        (conn.categoryMovie.value == "Popular")
            ? popular()
            : (conn.categoryMovie.value == "Top Rated")
                ? topRated()
                : (conn.categoryMovie.value == "Upcoming")
                    ? upComing()
                    : nowPlaying(),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: conn.listPage,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textDefault("Pages : " + "${widget.page}", Colors.white, 12,
                FontWeight.normal),
          ],
        ),
      ],
    );
  }

  Widget popular() {
    return FutureBuilder<List<PopularModel>>(
        future: getPopular("${widget.page}"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  var data = snapshot.data;
                  return InkWell(
                    onTap: () {
                      conn.tapMovie(
                          context,
                          data[i].title!,
                          data[i].backdropPath!,
                          data[i].id!,
                          data[i].overview!,
                          data[i].posterPath!,
                          "${data[i].voteAverage!}",
                          "${data[i].voteCount!}",
                          data[i].releaseDate!);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w300${data![i].posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textDefault(data[i].title!, Colors.white, 18,
                                    FontWeight.bold),
                                SizedBox(
                                  height: 10,
                                ),
                                data[i].overview! != ""
                                    ? Text(
                                        data[i].overview!,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    textDefault("${data[i].voteAverage!}",
                                        Colors.white, 14, FontWeight.normal),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return PlayStoreShimmer();
          }
          return PlayStoreShimmer();
        });
  }

  Widget topRated() {
    return FutureBuilder<List<TopRatedModel>>(
        future: getTopRated("${widget.page}"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  var data = snapshot.data;
                  return InkWell(
                    onTap: () {
                      conn.tapMovie(
                          context,
                          data[i].title!,
                          data[i].backdropPath!,
                          data[i].id!,
                          data[i].overview!,
                          data[i].posterPath!,
                          "${data[i].voteAverage!}",
                          "${data[i].voteCount!}",
                          data[i].releaseDate!);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w300${data![i].posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textDefault(data[i].title!, Colors.white, 18,
                                    FontWeight.bold),
                                SizedBox(
                                  height: 10,
                                ),
                                data[i].overview! != ""
                                    ? Text(
                                        data[i].overview!,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    textDefault("${data[i].voteAverage!}",
                                        Colors.white, 14, FontWeight.normal),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return PlayStoreShimmer();
          }
          return PlayStoreShimmer();
        });
  }

  Widget upComing() {
    return FutureBuilder<List<UpcomingModel>>(
        future: getUpcoming("${widget.page}"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  var data = snapshot.data;
                  return InkWell(
                    onTap: () {
                      conn.tapMovie(
                          context,
                          data[i].title!,
                          data[i].backdropPath!,
                          data[i].id!,
                          data[i].overview!,
                          data[i].posterPath!,
                          "${data[i].voteAverage!}",
                          "${data[i].voteCount!}",
                          data[i].releaseDate!);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w300${data![i].posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textDefault(data[i].title!, Colors.white, 18,
                                    FontWeight.bold),
                                SizedBox(
                                  height: 10,
                                ),
                                data[i].overview! != ""
                                    ? Text(
                                        data[i].overview!,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    textDefault("${data[i].voteAverage!}",
                                        Colors.white, 14, FontWeight.normal),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return PlayStoreShimmer();
          }
          return PlayStoreShimmer();
        });
  }

  Widget nowPlaying() {
    return FutureBuilder<List<NowPlayingModel>>(
        future: getNowPlaying("${widget.page}"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  var data = snapshot.data;
                  return InkWell(
                    onTap: () {
                      conn.tapMovie(
                          context,
                          data[i].title!,
                          data[i].backdropPath!,
                          data[i].id!,
                          data[i].overview!,
                          data[i].posterPath!,
                          "${data[i].voteAverage!}",
                          "${data[i].voteCount!}",
                          data[i].releaseDate!);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w300${data![i].posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textDefault(data[i].title!, Colors.white, 18,
                                    FontWeight.bold),
                                SizedBox(
                                  height: 10,
                                ),
                                data[i].overview! != ""
                                    ? Text(
                                        data[i].overview!,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    textDefault("${data[i].voteAverage!}",
                                        Colors.white, 14, FontWeight.normal),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return PlayStoreShimmer();
          }
          return PlayStoreShimmer();
        });
  }
}
