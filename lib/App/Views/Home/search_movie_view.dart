// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/App/Components/Widget/Container/container.dart';
import 'package:movie_time/App/Components/Widget/Text/text_stye.dart';
import 'package:movie_time/App/Controllers/Home/search_movie_controller.dart';
import 'package:movie_time/App/Models/Home/search_model.dart';
import 'package:movie_time/App/Services/Home/home_service.dart';
import 'package:movie_time/App/Views/Home/home_view.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  final conn = Get.put(SearchMovieController());
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
        textDefault(conn.title.value, Colors.white, 20, FontWeight.bold),
        SizedBox(
          height: 20,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.5),
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: conn.search,
                    style:
                        TextStyle(fontFamily: 'poppins', color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.white.withOpacity(0.2)),
                    ),
                    onChanged: (value) {
                      conn.onChangeText(value);
                      oc();
                    },
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: Colors.white.withOpacity(0.3),
        ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder<List<SearchModel>>(
            future: getSearch(conn.search.text),
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
                                    textDefault(data[i].title!, Colors.white,
                                        18, FontWeight.bold),
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
                                                color: Colors.white
                                                    .withOpacity(0.8)),
                                          )
                                        : Container(),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        textDefault(
                                            "${data[i].voteAverage!}",
                                            Colors.white,
                                            14,
                                            FontWeight.normal),
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
                return Container();
              }
              return Center(
                child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.5)),
              );
            })
      ],
    );
  }

  oc() {
    setState(() {
      getSearch(conn.search.text);
    });
  }
}
