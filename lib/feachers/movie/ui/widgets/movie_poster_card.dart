import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/core/style/colors.dart';
import 'package:flutter_application_1/feachers/home/models/movies_response_model.dart';
import 'package:flutter_application_1/feachers/movie_details/ui/movie_details_screen.dart';

class MoviePosterCard extends StatelessWidget {
  final MovieModel movie;
  final double width;
  final double posterHeight;

  const MoviePosterCard({
    super.key,
    required this.movie,
    this.width = 148,
    this.posterHeight = 214,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.62);

    return SizedBox(
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movieModel: movie),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PosterImage(movie: movie, height: posterHeight),
            const SizedBox(height: 10),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                height: 1.18,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 13,
                  color: mutedColor,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _releaseYear(movie.releaseDate),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: mutedColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _releaseYear(String? releaseDate) {
    if (releaseDate == null || releaseDate.isEmpty) {
      return 'Coming soon';
    }
    return releaseDate.split('-').first;
  }
}

class _PosterImage extends StatelessWidget {
  final MovieModel movie;
  final double height;

  const _PosterImage({required this.movie, required this.height});

  @override
  Widget build(BuildContext context) {
    final imagePath = movie.posterPath;
    final hasPoster = imagePath != null && imagePath.isNotEmpty;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasPoster)
              Image.network(
                '${ApiConstants.imagesBaseUrl}$imagePath',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const _PosterPlaceholder();
                },
                errorBuilder: (context, error, stackTrace) {
                  return const _PosterPlaceholder();
                },
              )
            else
              const _PosterPlaceholder(),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xB0000000)],
                ),
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: _RatingPill(rating: movie.voteAverage),
            ),
          ],
        ),
      ),
    );
  }
}

class _PosterPlaceholder extends StatelessWidget {
  const _PosterPlaceholder();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isDark ? AppColors.darkSurfaceSoft : AppColors.lightSurfaceSoft,
            isDark ? AppColors.darkSurface : AppColors.text30Color,
          ],
        ),
      ),
      child: Icon(
        Icons.local_movies_outlined,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
        size: 34,
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  final double? rating;

  const _RatingPill({required this.rating});

  @override
  Widget build(BuildContext context) {
    final value = rating == null ? '-' : rating!.toStringAsFixed(1);

    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            color: AppColors.primaryColor,
            size: 16,
          ),
          const SizedBox(width: 4),
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
