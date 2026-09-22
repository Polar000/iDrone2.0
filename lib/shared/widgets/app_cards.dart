import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';

class StatCard extends StatelessWidget {
  final String metric;
  final String label;
  final String feature1;
  final String feature2;

  const StatCard({
    super.key,
    required this.metric,
    required this.label,
    this.feature1 = 'Servicio rápido',
    this.feature2 = 'Servicio seguro',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: AppRadii.largeBorderRadius,
        boxShadow: isDark ? AppShadows.darkSoft : AppShadows.floating,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceElevated : AppColors.softGreen,
              borderRadius: AppRadii.mediumBorderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  metric,
                  style: AppTypography.headline(context, color: isDark ? AppColors.lime : AppColors.deepForest),
                ),
                Text(
                  label,
                  style: AppTypography.caption(context, color: isDark ? AppColors.darkMutedText : AppColors.mutedText),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 16, color: AppColors.emerald),
                    const SizedBox(width: 6),
                    Text(feature1, style: AppTypography.caption(context, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.verified, size: 16, color: AppColors.emerald),
                    const SizedBox(width: 6),
                    Text(feature2, style: AppTypography.caption(context, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.imagePath,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 200,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.white,
          borderRadius: AppRadii.largeBorderRadius,
          border: Border.all(
            color: isSelected
                ? AppColors.lime
                : (isDark ? AppColors.darkBorder : AppColors.border),
            width: isSelected ? 2.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: AppColors.lime.withOpacity(0.3), blurRadius: 12)]
              : AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    color: isDark ? AppColors.darkSurfaceElevated : AppColors.softGreen,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.forest,
                        child: const Icon(Icons.nature_people, color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.deepForest.withOpacity(0.85),
                      borderRadius: AppRadii.pillBorderRadius,
                    ),
                    child: Text(
                      badgeText,
                      style: AppTypography.caption(context, color: AppColors.lime, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body(context, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTypography.caption(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CropCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback? onTap;

  const CropCard({
    super.key,
    required this.name,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.emerald, width: 2),
              boxShadow: AppShadows.soft,
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.softGreen,
                  child: const Icon(Icons.grass, color: AppColors.forest),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: AppTypography.caption(context, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
