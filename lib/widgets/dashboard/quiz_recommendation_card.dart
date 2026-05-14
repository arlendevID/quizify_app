import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class QuizRecommendationCard extends StatelessWidget {
  final String title;
  final String badge;
  final int questionCount;
  final int estimatedMinutes;
  final IconData icon;
  final Gradient gradient;
  final bool darkText;
  final VoidCallback? onTap;

  const QuizRecommendationCard({
    super.key,
    required this.title,
    required this.badge,
    required this.questionCount,
    required this.estimatedMinutes,
    required this.icon,
    required this.gradient,
    this.darkText = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = darkText ? AppColors.textPrimary : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.16),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -18,
              bottom: -18,
              child: Icon(
                icon,
                size: 96,
                color: Colors.white.withOpacity(0.14),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    badge,
                    style: AppTextStyles.caption.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headingSmall.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.help_rounded,
                      color: textColor.withOpacity(0.78),
                      size: 17,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$questionCount soal',
                      style: AppTextStyles.caption.copyWith(
                        color: textColor.withOpacity(0.78),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.timer_rounded,
                      color: textColor.withOpacity(0.78),
                      size: 17,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$estimatedMinutes menit',
                      style: AppTextStyles.caption.copyWith(
                        color: textColor.withOpacity(0.78),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}