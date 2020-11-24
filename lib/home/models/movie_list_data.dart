class MovieListData {
  final String cover;
  final String title;

  MovieListData(this.cover, this.title);

  static List<MovieListData> fromResponse(Map<String, dynamic> response) {
    return (response['data']['movies'] as List<dynamic>)
        .map((data) => MovieListData(data['medium_cover_image'], data['title']))
        .toList();
  }
}
