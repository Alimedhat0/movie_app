class ApiConstants {
  ApiConstants._();

  static String baseUrl = "https://api.themoviedb.org/3/";
  static String apiKey = "fefe15fff323b2d1fabab195b5634d65";
  static String trendingMovies = 'trending/movie/day';
  static String nowPlaying = 'movie/now_playing';
  static String topRated = 'movie/top_rated';
  static String upcoming = 'movie/upcoming';
  static String movieDetails = 'movie/';
  static String movieSearch = 'search/movie';
  static String genre = 'genre/movie/list';
  static String credits = 'movie/{movie_id}/credits';
  static String imagesBaseUrl = 'https://image.tmdb.org/t/p/w500';
}
