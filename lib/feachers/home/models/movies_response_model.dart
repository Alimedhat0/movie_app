class MovieResponesModel {
  final int? page;
  final List<MovieModel> movies;
  final int? totalPages;
  final int? totalResults;

  MovieResponesModel({
    this.page,
    required this.movies,
    this.totalPages,
    this.totalResults,
  });

  factory MovieResponesModel.fromJson(Map<String, dynamic> json) {
    return MovieResponesModel(
      page: json['page'],
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
      movies:
          (json['results'] as List<dynamic>)
              .map((e) => MovieModel.fromJson(e))
              .toList(),
    );
  }
}

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final String? releaseDate;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: json['vote_average']?.toDouble(),
      releaseDate: json['release_date'] ?? '',
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
