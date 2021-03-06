import 'package:flutter/material.dart';
import 'package:flutter_movies/details/screen/details.dart';
import 'package:flutter_movies/home/models/movie_list_data.dart';
import 'package:flutter_movies/home/widgets/movie_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_movies/utils/endpoints.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MovieListData> movies = [];
  bool loading = false;
  int page = 1;
  int limit = 15;
  String path = 'list_movies.json';

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);

    _fetchMovies();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      page++;
      _fetchMovies();
    }
  }

  _fetchMovies() {
    if (loading) return;

    setState(() {
      loading = true;
    });

    final uri = formatUri(path, {
      'limit': limit.toString(),
      'page': page.toString(),
    });

    http.get(uri).then((response) {
      final responseData = jsonDecode(response.body);
      setState(() {
        loading = false;
        movies.addAll(MovieListData.fromResponse(responseData));
      });
    }).catchError((error) {
      print(error);
      loading = false;
    });
  }

  Function _onTapMovie(int movieID) {
    return () => Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Details(
            movieId: movieID,
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              controller: _controller,
              crossAxisCount: 3,
              childAspectRatio: 0.65,
              children: movies
                  .map((movie) => MovieItem(
                        title: movie.title,
                        cover: movie.cover,
                        onTap: _onTapMovie(movie.id),
                      ))
                  .toList(),
            ),
          ),
          loading ? LinearProgressIndicator() : Container(),
        ],
      ),
    );
  }
}
