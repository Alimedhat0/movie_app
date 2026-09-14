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
          (context) =>
              MovieDetailsProvider()
                ..getMovieDetails(movieModel.id)
                ..getMovieCredits(movieModel.id),
      child: Scaffold(
        appBar: AppBar(title: Text(movieModel.title)),
        body: Consumer<MovieDetailsProvider>(
          builder: (context, provider, _) {
            if (provider.movie == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieDetailsTitle(movieModel: movieModel),
                  const SizedBox(height: 22),
                  const MovieDetailsCastCrew(),
                  const SizedBox(height: 22),
                  const MovieDetailsCrew(),
                  const SizedBox(height: 28),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
