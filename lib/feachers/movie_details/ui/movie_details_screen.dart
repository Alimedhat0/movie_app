import 'package:flutter/material.dart';
import 'package:flutter_application_1/feachers/home/models/movies_response_model.dart';
import 'package:flutter_application_1/feachers/movie_details/logic/movie_details_provider.dart';
import 'package:flutter_application_1/feachers/movie_details/ui/widgets/movie_details_cast.dart';
import 'package:flutter_application_1/feachers/movie_details/ui/widgets/movie_details_crew.dart';
import 'package:flutter_application_1/feachers/movie_details/ui/widgets/movie_details_title.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movieModel;
  const MovieDetailsScreen({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) => MovieDetailsProvider()..getMovieDetails(movieModel.id),
      child: Scaffold(
        appBar: AppBar(title: Text(movieModel.title)),
        body: Consumer<MovieDetailsProvider>(
          builder: (context, provider, _) {
            if (provider.movie == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    MovieDetailsTitle(movieModel: movieModel),
                    MovieDetailsCastCrew(movieId: movieModel.id),
                    MovieDetailsCrew(movieId: movieModel.id),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
