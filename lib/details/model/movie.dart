class Movie {
  final String title;
  final String cover;
  final String background;
  final String description;
  final String rating;

  Movie(this.title, this.cover, this.background, this.description, this.rating);

  Movie.fromResponse(Map<String, dynamic> response)
      : this.title = response['data']['movie']['title_long'],
        this.cover = response['data']['movie']['large_cover_image'],
        this.background =
            response['data']['movie']['background_image_original'],
        this.description = response['data']['movie']['description_full'],
        this.rating = response['data']['movie']['rating'];
}
