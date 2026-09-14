import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/core/style/colors.dart';
import 'package:flutter_application_1/feachers/home/models/movies_response_model.dart';
import 'package:flutter_application_1/feachers/movie_details/logic/movie_details_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailsTitle extends StatelessWidget {
  final MovieModel movieModel;

  const MovieDetailsTitle({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieDetailsProvider>();
    final movie = provider.movie!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.62);
    final posterPath = _firstImage(movie.posterPath, movieModel.posterPath);
    final backdropPath = _firstImage(
      movie.backdropPath,
      movieModel.backdropPath,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 420,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 420,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (backdropPath.isNotEmpty)
                      Image.network(
                        '${ApiConstants.imagesBaseUrl}$backdropPath',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const _DetailsImageFallback();
                        },
                      )
                    else
                      const _DetailsImageFallback(),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x16000000),
                            Color(0x99000000),
                            Color(0xF0000000),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                top: 176,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 132,
                      height: 198,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.28),
                            blurRadius: 18,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            posterPath.isNotEmpty
                                ? Image.network(
                                  '${ApiConstants.imagesBaseUrl}$posterPath',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const _DetailsPosterFallback();
                                  },
                                )
                                : const _DetailsPosterFallback(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w900,
                                height: 1.05,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _InfoPill(
                                  icon: Icons.star_rounded,
                                  value: movie.voteAverage.toStringAsFixed(1),
                                  color: AppColors.primaryColor,
                                ),
                                _InfoPill(
                                  icon: Icons.schedule_rounded,
                                  value: _runtimeText(movie.runtime),
                                  color: AppColors.tealColor,
                                ),
                                _InfoPill(
                                  icon: Icons.calendar_month_outlined,
                                  value: _releaseYear(movie.releaseDate),
                                  color: AppColors.accentColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (movie.genres.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        movie.genres
                            .map((genre) => _GenreChip(label: genre.name))
                            .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  'Overview',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview.isEmpty ? movieModel.overview : movie.overview,
                  style: TextStyle(
                    color: mutedColor,
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _firstImage(String? primary, String? fallback) {
    if (primary != null && primary.isNotEmpty) return primary;
    if (fallback != null && fallback.isNotEmpty) return fallback;
    return '';
  }

  String _releaseYear(String? releaseDate) {
    if (releaseDate == null || releaseDate.isEmpty) return 'Soon';
    return releaseDate.split('-').first;
  }

  String _runtimeText(int runtime) {
    if (runtime <= 0) return 'Runtime TBA';
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    if (hours == 0) return '${minutes}m';
    return '${hours}h ${minutes}m';
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _InfoPill({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;

  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.primaryColor.withValues(alpha: 0.14)
                : AppColors.primarySurfaceColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        widthFactor: 1,
        child: Text(
          label,
          style: TextStyle(
            color: isDark ? AppColors.primaryColor : AppColors.text100Color,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _DetailsImageFallback extends StatelessWidget {
  const _DetailsImageFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.darkSurfaceSoft, AppColors.accentColor],
        ),
      ),
      child: Icon(Icons.movie_creation_outlined, color: Colors.white, size: 48),
    );
  }
}

class _DetailsPosterFallback extends StatelessWidget {
  const _DetailsPosterFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(color: AppColors.darkSurfaceSoft),
      child: Icon(Icons.local_movies_outlined, color: Colors.white, size: 34),
    );
  }
}
