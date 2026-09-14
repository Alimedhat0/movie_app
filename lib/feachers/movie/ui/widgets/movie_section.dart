import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/colors.dart';
import 'package:flutter_application_1/feachers/home/models/movies_response_model.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/movie_poster_card.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<MovieModel> movies;

  const MovieSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.58);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: mutedColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 286,
          child:
              movies.isEmpty
                  ? const _MovieSectionLoading()
                  : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder:
                        (context, index) => const SizedBox(width: 14),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return MoviePosterCard(movie: movies[index]);
                    },
                  ),
        ),
      ],
    );
  }
}

class _MovieSectionLoading extends StatelessWidget {
  const _MovieSectionLoading();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final lineColor =
        isDark ? AppColors.darkSurfaceSoft : AppColors.lightSurfaceSoft;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemBuilder: (context, index) {
        return SizedBox(
          width: 148,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 214,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 14,
                width: 132,
                decoration: BoxDecoration(
                  color: lineColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                width: 84,
                decoration: BoxDecoration(
                  color: lineColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
