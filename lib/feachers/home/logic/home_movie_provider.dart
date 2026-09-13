import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/helpers/local_storage.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/core/networking/dio_factory.dart';
import 'package:flutter_application_1/feachers/home/models/movies_response_model.dart';

class HomeMovieProvider extends ChangeNotifier {
  List<MovieModel> topRatedMovies = [];

  void getTopRatedMovies() async {
    try {
      final response = await DioFactory.getData(
        ApiConstants.topRated,
        queryParameters: {'api_key': ApiConstants.apiKey, 'language': 'en-US'},
      );
      final data = MovieResponesModel.fromJson(response.data);
      topRatedMovies = data.movies;
      notifyListeners();
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  List<MovieModel> trendingMovies = [];

  void getTrendingMovies() async {
    try {
      final response = await DioFactory.getData(
        ApiConstants.trendingMovies,
        queryParameters: {'api_key': ApiConstants.apiKey, 'language': 'en-US'},
      );
      final data = MovieResponesModel.fromJson(response.data);
      trendingMovies = data.movies;
      notifyListeners();
    } catch (e) {
      print('Error fetching movies trending: $e');
    }
  }

  List<MovieModel> nowPlayingMovies = [];
  void getNowPlayingMovies() async {
    try {
      final response = await DioFactory.getData(
        ApiConstants.nowPlaying,
        queryParameters: {'api_key': ApiConstants.apiKey, 'language': 'en-US'},
      );
      final data = MovieResponesModel.fromJson(response.data);
      nowPlayingMovies = data.movies;
      notifyListeners();
    } catch (e) {
      print('Error fetching movies now playing: $e');
    }
  }

  List<MovieModel> upComingMovies = [];
  void getUpComingMovies() async {
    try {
      final response = await DioFactory.getData(
        ApiConstants.upcoming,
        queryParameters: {'api_key': ApiConstants.apiKey, 'language': 'en-US'},
      );
      final data = MovieResponesModel.fromJson(response.data);
      upComingMovies = data.movies;
      notifyListeners();
    } catch (e) {
      print('Error fetching movies upcoming: $e');
    }
  }

  void searchForMovies(String search) async {
    try {
      final response = await DioFactory.getData(
        ApiConstants.movieSearch,
        queryParameters: {
          'api_key': ApiConstants.apiKey,
          'query': search,
          'language': 'en-US',
        },
      );
      final data = MovieResponesModel.fromJson(response.data);
      trendingMovies = data.movies;
      notifyListeners();
    } catch (e) {
      print('Error searching for movies: $e');
    }
  }

  bool getIsDark() => LocalStorage.getBool('isDark') ?? false;

  void toggleDarkMode() async {
    await LocalStorage.setBool('isDark', !getIsDark());
    notifyListeners();
  }
}
