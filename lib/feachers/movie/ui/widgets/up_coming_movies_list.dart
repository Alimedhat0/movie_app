import 'package:flutter/material.dart';
import 'package:flutter_application_1/feachers/home/logic/home_movie_provider.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/movie_section.dart';
import 'package:provider/provider.dart';

class UpComingMoviesList extends StatelessWidget {
  const UpComingMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMovieProvider>(
      builder: (context, provider, _) {
        return MovieSection(
          title: 'Coming Soon',
          subtitle: 'Keep these on your watchlist',
          movies: provider.upComingMovies,
        );
      },
    );
  }
}
