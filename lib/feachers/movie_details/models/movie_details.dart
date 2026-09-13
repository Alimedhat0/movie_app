class MovieDetailsResponesModel {
  final int page;
  final int totalPages;
  final int totalResults;
  final MovieDetailsModel movie;

  MovieDetailsResponesModel({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.movie,
  });

  factory MovieDetailsResponesModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponesModel(
      page: json['page'],
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
      movie: MovieDetailsModel.fromJson(json['results']),
    );
  }
}

class MovieDetailsModel {
  final String? posterPath;
  final String? backdropPath;
  final String title;
  final String? releaseDate;
  final double voteAverage;
  final int id;
  final String overview;
  final int runtime;
  final List<Genres> genres;

  MovieDetailsModel({
    required this.posterPath,
    required this.backdropPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.id,
    required this.overview,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'],
      runtime: json['runtime'],
      title: json['title'] ?? '',
      genres:
          (json['genres'] as List<dynamic>)
              .map((e) => Genres.fromJson(e))
              .toList(),
      releaseDate: json['release_date'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: json['vote_average']?.toDouble(),
    );
  }
}

class Genres {
  final int id;
  final String name;

  Genres({required this.id, required this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(id: json['id'], name: json['name']);
  }
}
