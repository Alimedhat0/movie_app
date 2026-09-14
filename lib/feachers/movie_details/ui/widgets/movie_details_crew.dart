import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/colors.dart';
import 'package:flutter_application_1/feachers/movie_details/logic/movie_details_provider.dart';
import 'package:flutter_application_1/feachers/movie_details/ui/widgets/credit_person_card.dart';
import 'package:provider/provider.dart';

class MovieDetailsCrew extends StatelessWidget {
  const MovieDetailsCrew({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailsProvider>(
      builder: (context, provider, _) {
        if (provider.credits == null) {
          return const _CreditsLoading(title: 'Top Crew');
        }

        final crew = provider.credits!.crew.take(10).toList();

        return _CreditsSection(
          title: 'Top Crew',
          child: SizedBox(
            height: 176,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: crew.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final person = crew[index];
                return CreditPersonCard(
                  name: person.name,
                  subtitle: person.job,
                  profilePath: person.profilePath,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _CreditsSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _CreditsSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 14),
        child,
      ],
    );
  }
}

class _CreditsLoading extends StatelessWidget {
  final String title;

  const _CreditsLoading({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return _CreditsSection(
      title: title,
      child: SizedBox(
        height: 176,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return Container(
              width: 104,
              height: 116,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          },
        ),
      ),
    );
  }
}
