import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/feachers/home/models/movies_response_model.dart';
import 'package:flutter_application_1/feachers/movie_details/logic/movie_details_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailsTitle extends StatelessWidget {
  final MovieModel movieModel;

  const MovieDetailsTitle({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MovieDetailsProvider>();
    return ChangeNotifierProvider(
      create: (context) {
        return provider..getMovieDetails(movieModel.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${ApiConstants.imagesBaseUrl}${movieModel.posterPath}',
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      movieModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    'Genres: ${provider.movie!.genres.map((e) => e.name).join(', ')}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: Text(
                      movieModel.overview,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      Text(
                        'Release Date: ${movieModel.releaseDate.toString()}',
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          Text('Rating: '),
                          Icon(Icons.star, color: Colors.amber),
                          Text(movieModel.voteAverage.toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
