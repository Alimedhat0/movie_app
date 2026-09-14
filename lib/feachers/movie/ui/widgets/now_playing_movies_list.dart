import 'package:flutter/material.dart';
import 'package:flutter_application_1/feachers/home/logic/home_movie_provider.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/movie_section.dart';
import 'package:provider/provider.dart';

class NowPlayingMoviesList extends StatelessWidget {
  const NowPlayingMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMovieProvider>(
      builder: (context, provider, _) {
        return MovieSection(
          title: 'Now Playing',
          subtitle: 'Fresh releases currently in theaters',
          movies: provider.nowPlayingMovies,
        );
      },
    );
  }
}
