import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/core/style/colors.dart';
import 'package:flutter_application_1/feachers/home/logic/home_movie_provider.dart';
import 'package:flutter_application_1/feachers/home/models/movies_response_model.dart';
import 'package:flutter_application_1/feachers/movie_details/ui/movie_details_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  bool _hasSearched = false;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final trimmedQuery = query.trim();
      if (trimmedQuery.isEmpty) {
        setState(() => _hasSearched = false);
        context.read<HomeMovieProvider>().clearSearchResults();
        return;
      }

      setState(() => _hasSearched = true);
      context.read<HomeMovieProvider>().searchForMovies(trimmedQuery);
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
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.58);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              child: TextField(
                controller: _controller,
                autofocus: true,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: 'Search movies, actors, stories...',
                  hintStyle: TextStyle(color: mutedColor),
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon:
                      _controller.text.isEmpty
                          ? null
                          : IconButton(
                            tooltip: 'Clear search',
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              _controller.clear();
                              setState(() => _hasSearched = false);
                              provider.clearSearchResults();
                            },
                          ),
                ),
                onChanged: (value) {
                  setState(() {});
                  _onSearchChanged(value);
                },
              ),
            ),
            Expanded(
              child:
                  !_hasSearched
                      ? _SearchEmptyState(
                        title: 'Ready when you are',
                        message:
                            'Type a movie name and I will bring the posters.',
                        icon: Icons.movie_filter_outlined,
                      )
                      : provider.searchResults.isEmpty
                      ? _SearchEmptyState(
                        title: 'No movies found',
                        message: 'Try a shorter title or another keyword.',
                        icon: Icons.search_off_rounded,
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 12),
                        itemCount: provider.searchResults.length,
                        itemBuilder: (context, index) {
                          return _SearchResultCard(
                            movie: provider.searchResults[index],
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final MovieModel movie;

  const _SearchResultCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.58);
    final posterPath = movie.posterPath;
    final hasPoster = posterPath != null && posterPath.isNotEmpty;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movieModel: movie),
          ),
        );
      },
      child: Container(
        height: 148,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : AppColors.text30Color,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 84,
                height: 128,
                child:
                    hasPoster
                        ? Image.network(
                          '${ApiConstants.imagesBaseUrl}$posterPath',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const _SearchPosterFallback();
                          },
                        )
                        : const _SearchPosterFallback(),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      height: 1.12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _SmallMeta(
                        icon: Icons.star_rounded,
                        value:
                            movie.voteAverage == null
                                ? '-'
                                : movie.voteAverage!.toStringAsFixed(1),
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _releaseYear(movie.releaseDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: mutedColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.overview.isEmpty
                        ? 'No overview available yet.'
                        : movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: mutedColor,
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              color: textColor.withValues(alpha: 0.44),
            ),
          ],
        ),
      ),
    );
  }

  String _releaseYear(String? releaseDate) {
    if (releaseDate == null || releaseDate.isEmpty) return 'Coming soon';
    return releaseDate.split('-').first;
  }
}

class _SmallMeta extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _SmallMeta({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 3),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _SearchPosterFallback extends StatelessWidget {
  const _SearchPosterFallback();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceSoft : AppColors.lightSurfaceSoft,
      ),
      child: Icon(
        Icons.local_movies_outlined,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.42),
      ),
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const _SearchEmptyState({
    required this.title,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.58);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 34),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mutedColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
