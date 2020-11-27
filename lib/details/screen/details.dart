import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_movies/details/model/movie.dart';
import 'package:flutter_movies/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final int movieId;

  Details({this.movieId});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool loading = false;
  Movie movie;

  @override
  void initState() {
    super.initState();

    _fetchMovie();
  }

  _fetchMovie() {
    if (loading) return;

    setState(() {
      loading = true;
    });

    final uri = formatUri('movie_details.json', {
      'movie_id': widget.movieId.toString(),
    });

    http.get(uri).then((response) {
      final responseData = jsonDecode(response.body);
      setState(() {
        loading = false;
        movie = Movie.fromResponse(responseData);
      });
    }).catchError((error) {
      print(error);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movie?.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Image.network(
                      movie?.cover,
                      height: 200,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              movie?.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              movie?.description,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              movie?.title,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
