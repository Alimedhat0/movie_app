import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/core/style/colors.dart';
import 'package:flutter_application_1/feachers/home/logic/home_movie_provider.dart';
import 'package:flutter_application_1/feachers/home/models/movies_response_model.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/now_playing_movies_list.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/search_result_list.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/top_rated_movies_list.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/trending_movies_list.dart';
import 'package:flutter_application_1/feachers/movie/ui/widgets/up_coming_movies_list.dart';
import 'package:flutter_application_1/feachers/movie_details/ui/movie_details_screen.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  bool _didLoadMovies = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didLoadMovies) return;

    context.read<HomeMovieProvider>()
      ..getUpComingMovies()
      ..getTrendingMovies()
      ..getNowPlayingMovies()
      ..getTopRatedMovies();
    _didLoadMovies = true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeMovieProvider>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _MovieHomeHeader(
                isDark: provider.getIsDark(),
                onSearchTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                onThemeTap: provider.toggleDarkMode,
              ),
            ),
            SliverToBoxAdapter(
              child: _SpotlightCard(
                movie:
                    provider.trendingMovies.isEmpty
                        ? null
                        : provider.trendingMovies.first,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
            const SliverToBoxAdapter(child: TrendingMoviesList()),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
            const SliverToBoxAdapter(child: TopRatedMoviesList()),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
            const SliverToBoxAdapter(child: NowPlayingMoviesList()),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
            const SliverToBoxAdapter(child: UpComingMoviesList()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _MovieHomeHeader extends StatelessWidget {
  final bool isDark;
  final VoidCallback onSearchTap;
  final VoidCallback onThemeTap;

  const _MovieHomeHeader({
    required this.isDark,
    required this.onSearchTap,
    required this.onThemeTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.62);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MOVIE VERSE',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Find your next story',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Trending, top rated, and fresh cinema picks.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: mutedColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _HeaderIconButton(
            tooltip: 'Search',
            icon: Icons.search_rounded,
            onTap: onSearchTap,
          ),
          const SizedBox(width: 8),
          _HeaderIconButton(
            tooltip: isDark ? 'Light mode' : 'Dark mode',
            icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            onTap: onThemeTap,
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon),
        style: IconButton.styleFrom(
          fixedSize: const Size(44, 44),
          backgroundColor:
              isDark ? AppColors.darkSurface : AppColors.lightSurface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class _SpotlightCard extends StatelessWidget {
  final MovieModel? movie;

  const _SpotlightCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final selectedMovie = movie;

    if (selectedMovie == null) {
      return const _SpotlightLoading();
    }

    final imagePath =
        _hasImage(selectedMovie.backdropPath)
            ? selectedMovie.backdropPath
            : selectedMovie.posterPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => MovieDetailsScreen(movieModel: selectedMovie),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 224,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (_hasImage(imagePath))
                  Image.network(
                    '${ApiConstants.imagesBaseUrl}$imagePath',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const _SpotlightFallback();
                    },
                  )
                else
                  const _SpotlightFallback(),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x22000000),
                        Color(0x55000000),
                        Color(0xE6000000),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tonight spotlight',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedMovie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedMovie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.78),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _SpotlightMeta(
                            icon: Icons.star_rounded,
                            value:
                                selectedMovie.voteAverage == null
                                    ? '-'
                                    : selectedMovie.voteAverage!
                                        .toStringAsFixed(1),
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 8),
                          _SpotlightMeta(
                            icon: Icons.calendar_month_outlined,
                            value: _releaseYear(selectedMovie.releaseDate),
                            color: AppColors.tealColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _hasImage(String? path) => path != null && path.isNotEmpty;

  String _releaseYear(String? releaseDate) {
    if (releaseDate == null || releaseDate.isEmpty) return 'Soon';
    return releaseDate.split('-').first;
  }
}

class _SpotlightMeta extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _SpotlightMeta({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.52),
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

class _SpotlightLoading extends StatelessWidget {
  const _SpotlightLoading();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 224,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _SpotlightFallback extends StatelessWidget {
  const _SpotlightFallback();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isDark ? AppColors.darkSurfaceSoft : AppColors.text80Color,
            AppColors.accentColor,
          ],
        ),
      ),
      child: const Icon(
        Icons.movie_creation_outlined,
        color: Colors.white,
        size: 48,
      ),
    );
  }
}
