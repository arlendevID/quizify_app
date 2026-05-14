import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/custom_button.dart';

class QuizListTile extends StatelessWidget {
  final String title;
  final String description;
  final String difficulty;
  final int questionCount;
  final int durationMinutes;
  final IconData icon;
  final String buttonText;
  final VoidCallback? onTap;
  final bool isCompact;

  const QuizListTile({
    super.key,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.questionCount,
    required this.durationMinutes,
    required this.icon,
    required this.buttonText,
    this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final difficultyColors = _difficultyColors(difficulty);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: AppColors.bluePurpleGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headingSmall.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: difficultyColors.background,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  difficulty,
                  style: AppTextStyles.caption.copyWith(
                    color: difficultyColors.foreground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            description,
            maxLines: isCompact ? 2 : 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _MetaInfo(
                icon: Icons.help_rounded,
                text: '$questionCount Soal',
              ),
              const SizedBox(width: 14),
              _MetaInfo(
                icon: Icons.timer_rounded,
                text: '$durationMinutes Menit',
              ),
            ],
          ),
          const SizedBox(height: 18),
          CustomButton(
            text: buttonText,
            onPressed: onTap,
            type: buttonText.toLowerCase().contains('detail')
                ? QuizifyButtonType.outlined
                : QuizifyButtonType.primary,
            height: 52,
          ),
        ],
      ),
    );
  }

  _DifficultyStyle _difficultyColors(String value) {
    switch (value.toUpperCase()) {
      case 'MUDAH':
        return _DifficultyStyle(
          background: AppColors.success.withOpacity(0.14),
          foreground: AppColors.success,
        );
      case 'MENENGAH':
        return _DifficultyStyle(
          background: AppColors.tertiary.withOpacity(0.20),
          foreground: const Color(0xFFB77900),
        );
      case 'SULIT':
        return _DifficultyStyle(
          background: AppColors.error.withOpacity(0.13),
          foreground: AppColors.error,
        );
      default:
        return _DifficultyStyle(
          background: AppColors.primary.withOpacity(0.12),
          foreground: AppColors.primary,
        );
    }
  }
}

class _MetaInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaInfo({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.textMuted,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DifficultyStyle {
  final Color background;
  final Color foreground;

  const _DifficultyStyle({
    required this.background,
    required this.foreground,
  });
}