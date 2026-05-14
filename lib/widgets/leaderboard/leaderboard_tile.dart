import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class LeaderboardTile extends StatelessWidget {
  final int rank;
  final String name;
  final String levelText;
  final String xp;
  final String? avatarUrl;
  final String? avatarAsset;
  final bool isCurrentUser;
  final VoidCallback? onTap;

  const LeaderboardTile({
    super.key,
    required this.rank,
    required this.name,
    required this.levelText,
    required this.xp,
    this.avatarUrl,
    this.avatarAsset,
    this.isCurrentUser = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isCurrentUser
                ? AppColors.primary.withOpacity(0.55)
                : Colors.transparent,
            width: isCurrentUser ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isCurrentUser
                  ? AppColors.primary.withOpacity(0.16)
                  : AppColors.primary.withOpacity(0.07),
              blurRadius: isCurrentUser ? 28 : 22,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: isCurrentUser ? AppColors.bluePurpleGradient : null,
                color: isCurrentUser ? null : AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isCurrentUser ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            _Avatar(
              avatarUrl: avatarUrl,
              avatarAsset: avatarAsset,
              isCurrentUser: isCurrentUser,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    levelText,
                    style: AppTextStyles.caption.copyWith(
                      color: isCurrentUser
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight:
                          isCurrentUser ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? AppColors.primary.withOpacity(0.10)
                    : AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                xp,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isCurrentUser
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? avatarUrl;
  final String? avatarAsset;
  final bool isCurrentUser;

  const _Avatar({
    this.avatarUrl,
    this.avatarAsset,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (avatarAsset != null) {
      child = Image.asset(
        avatarAsset!,
        fit: BoxFit.cover,
      );
    } else if (avatarUrl != null) {
      child = Image.network(
        avatarUrl!,
        fit: BoxFit.cover,
      );
    } else {
      child = Icon(
        isCurrentUser ? Icons.person_pin_rounded : Icons.person_rounded,
        color: Colors.white,
        size: 26,
      );
    }

    return Container(
      width: 48,
      height: 48,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: isCurrentUser
            ? AppColors.bluePurpleGradient
            : LinearGradient(
                colors: [
                  AppColors.neutral.withOpacity(0.85),
                  AppColors.secondary.withOpacity(0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        shape: BoxShape.circle,
      ),
      child: Center(child: child),
    );
  }
}