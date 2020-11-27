class MovieListData {
  final int id;
  final String cover;
  final String title;

  MovieListData(this.id, this.cover, this.title);

  static List<MovieListData> fromResponse(Map<String, dynamic> response) {
    return (response['data']['movies'] as List<dynamic>)
        .map((data) => MovieListData(
            data['id'], data['medium_cover_image'], data['title']))
        .toList();
  }
}
