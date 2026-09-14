import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/core/networking/dio_factory.dart';
import 'package:flutter_application_1/feachers/movie_details/models/credits_model.dart';
import 'package:flutter_application_1/feachers/movie_details/models/movie_details.dart';

class MovieDetailsProvider extends ChangeNotifier {
  MovieDetailsModel? movie;
  MovieCreditsModel? credits;

  bool isLoading = false;

  void getMovieDetails(int id) async {
    try {
      movie = null;
      isLoading = true;
      notifyListeners();
      final response = await DioFactory.getData(
        '${ApiConstants.baseUrl}${ApiConstants.movieDetails}$id',
      );
      movie = MovieDetailsModel.fromJson(response.data);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching movie details: $e');
    }
  }

  void getMovieCredits(int id) async {
    try {
      credits = null;
      notifyListeners();
      final response = await DioFactory.getData(
        '${ApiConstants.baseUrl}${ApiConstants.credits.replaceAll('{movie_id}', id.toString())}',
      );
      credits = MovieCreditsModel.fromJson(response.data);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching credits: $e');
    }
  }
}
