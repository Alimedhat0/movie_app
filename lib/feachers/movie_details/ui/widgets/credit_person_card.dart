import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/networking/api_constants.dart';
import 'package:flutter_application_1/core/style/colors.dart';

class CreditPersonCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String? profilePath;

  const CreditPersonCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.profilePath,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.58);
    final hasImage = profilePath != null && profilePath!.isNotEmpty;

    return SizedBox(
      width: 104,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 116,
            width: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.16),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  hasImage
                      ? Image.network(
                        '${ApiConstants.imagesBaseUrl}$profilePath',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const _CreditAvatarFallback();
                        },
                      )
                      : const _CreditAvatarFallback(),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle.isEmpty ? 'Cast' : subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: mutedColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.18,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditAvatarFallback extends StatelessWidget {
  const _CreditAvatarFallback();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceSoft : AppColors.lightSurfaceSoft,
      ),
      child: Icon(
        Icons.person_rounded,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.46),
        size: 36,
      ),
    );
  }
}
