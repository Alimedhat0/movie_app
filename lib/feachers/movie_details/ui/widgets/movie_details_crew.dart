import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/feachers/movie_details/logic/movie_details_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailsCrew extends StatelessWidget {
  final int movieId;
  const MovieDetailsCrew({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsProvider()..getMovieCredits(movieId),
      child: Consumer<MovieDetailsProvider>(
        builder: (context, provider, _) {
          if (provider.credits == null) {
            return Center(child: CircularProgressIndicator());
          }

          final credits = provider.credits!;
          final crew = credits.crew.take(5).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Top Crew",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: crew.length,
                  itemBuilder: (context, index) {
                    final actor = crew[index];
                    return Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              '${ApiConstants.imagesBaseUrl}${actor.profilePath}',
                              height: 100,
                              width: 80,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.person, size: 80),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            actor.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            actor.job,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
