import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/feachers/home/logic/home_movie_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        context.read<HomeMovieProvider>().searchForMovies(query);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeMovieProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          Expanded(
            child:
                provider.trendingMovies.isEmpty
                    ? Center(child: Text('No movies found'))
                    : ListView.separated(
                      separatorBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: SizedBox(
                              height: 10,
                              width: 100,
                              child: Divider(),
                            ),
                          ),
                      itemCount: provider.trendingMovies.length,
                      itemBuilder: (context, index) {
                        final movie = provider.trendingMovies[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            height: 420,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              spacing: 10,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    '${ApiConstants.imagesBaseUrl}${movie.posterPath}',
                                    fit: BoxFit.cover,
                                    width: 250,
                                    height: 320,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error, size: 50);
                                    },
                                  ),
                                ),
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  movie.overview,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
