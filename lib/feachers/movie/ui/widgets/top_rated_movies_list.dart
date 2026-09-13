import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/feachers/home/logic/home_movie_provider.dart';
import 'package:flutter_application_1/feachers/movie_details/ui/movie_details_screen.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesList extends StatelessWidget {
  const TopRatedMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMovieProvider>(
      builder: (context, provider, _) {
        return SizedBox(
          width: double.infinity,
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemCount: provider.topRatedMovies.length,
            itemBuilder: (context, index) {
              final movie = provider.topRatedMovies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => MovieDetailsScreen(movieModel: movie),
                    ),
                  );
                },
                child: SizedBox(
                  width: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (movie.posterPath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            '${ApiConstants.imagesBaseUrl}${movie.posterPath}',
                            width: 130,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Icon(Icons.error),
                      SizedBox(height: 10),
                      Text(
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        movie.releaseDate ?? '',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
