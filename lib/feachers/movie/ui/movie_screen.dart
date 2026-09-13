import 'package:flutter/material.dart';
import 'package:flutter_application_1/feachers/home/logic/home_movie_provider.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/now_playing_movies_list.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/search_result_list.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/top_rated_movies_list.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/trending_movies_list.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/up_coming_movies_list.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) =>
              HomeMovieProvider()
                ..getUpComingMovies()
                ..getTrendingMovies()
                ..getNowPlayingMovies()
                ..getTopRatedMovies(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                context.read<HomeMovieProvider>().toggleDarkMode();
              },
              icon: Icon(Icons.brightness_6),
            ),
          ],
        ),
        body: Consumer<HomeMovieProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'Trending Movies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TrendingMoviesList(),
                    SizedBox(height: 10),
                    Text(
                      'Top Rated Movies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TopRatedMoviesList(),
                    SizedBox(height: 10),
                    Text(
                      'Now Playing Movies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    NowPlayingMoviesList(),

                    SizedBox(height: 10),
                    Text(
                      'Upcoming Movies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    UpComingMoviesList(),
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
