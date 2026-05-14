import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final int quizCount;
  final IconData icon;
  final Color color;
  final bool darkText;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.quizCount,
    required this.icon,
    required this.color,
    this.darkText = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = darkText ? AppColors.textPrimary : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.24),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -18,
              bottom: -22,
              child: Icon(
                icon,
                size: 86,
                color: Colors.white.withOpacity(0.13),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    icon,
                    color: textColor,
                    size: 26,
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  style: AppTextStyles.headingSmall.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$quizCount kuis tersedia',
                  style: AppTextStyles.caption.copyWith(
                    color: textColor.withOpacity(0.76),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}