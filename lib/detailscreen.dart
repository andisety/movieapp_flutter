import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/model/movie.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: const Color.fromARGB(78, 158, 158, 158),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      ),
    );
  }
}

class Detail extends StatefulWidget {
  final Movie movie;
  const Detail({super.key, required this.movie});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(
                "http://image.tmdb.org/t/p/w500/${widget.movie.posterPath}"),
          ),
          SafeArea(child: buttonArrow(context)),
          scroll()
        ],
      ),
      floatingActionButton: FavoriteButton(),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
        minChildSize: 0.3,
        builder: (context, scrollController) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 35,
                          height: 5,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.movie.originalTitle.toString(),
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        const Text("Description :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.movie.overview.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Release Date :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.movie.releaseDate.toString()),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("Rating :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        RatingBar.builder(
                          initialRating:
                              (widget.movie.voteAverage! / 2).toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            height: 50,
            width: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ))),
      ),
    );
  }
}
