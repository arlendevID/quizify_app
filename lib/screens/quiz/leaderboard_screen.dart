import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/route_names.dart';
import '../../widgets/leaderboard/leaderboard_tile.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  void _goBackToDashboard(BuildContext context) {
    var dashboardFound = false;

    Navigator.popUntil(context, (route) {
      if (route.settings.name == RouteNames.dashboard) {
        dashboardFound = true;
        return true;
      }

      return route.isFirst;
    });

    if (!dashboardFound) {
      Navigator.pushReplacementNamed(context, RouteNames.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 118),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header(),
                  const SizedBox(height: 24),
                  const _TabSwitch(),
                  const SizedBox(height: 30),
                  const _TopThreeRanking(),
                  const SizedBox(height: 30),
                  Text(
                    'Ranking Mingguan',
                    style: AppTextStyles.headingMedium.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const LeaderboardTile(
                    rank: 4,
                    name: 'Elena K.',
                    levelText: 'Lvl 11',
                    xp: '9.5k XP',
                  ),
                  const SizedBox(height: 14),
                  const LeaderboardTile(
                    rank: 5,
                    name: 'Dante S.',
                    levelText: 'Lvl 10',
                    xp: '8.2k XP',
                  ),
                  const SizedBox(height: 14),
                  const LeaderboardTile(
                    rank: 6,
                    name: 'Sophie L.',
                    levelText: 'Lvl 9',
                    xp: '7.9k XP',
                  ),
                  const SizedBox(height: 14),
                  const LeaderboardTile(
                    rank: 7,
                    name: 'Victor P.',
                    levelText: 'Lvl 9',
                    xp: '7.1k XP',
                  ),
                  const SizedBox(height: 22),
                  const LeaderboardTile(
                    rank: 42,
                    name: 'Anda',
                    levelText: 'Teruslah berjuang!',
                    xp: '2.4k XP',
                    isCurrentUser: true,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 18,
              child: _BottomNav(
                onHomeTap: () => _goBackToDashboard(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: AppColors.bluePurpleGradient,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.bolt_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Quizify',
          style: AppTextStyles.headingLarge.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.10),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            'Lvl 12',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _TabSwitch extends StatelessWidget {
  const _TabSwitch();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: const [
          Expanded(
            child: _TabItem(
              title: 'Weekly',
              isActive: true,
            ),
          ),
          Expanded(
            child: _TabItem(
              title: 'All-time',
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isActive;

  const _TabItem({
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 48,
      decoration: BoxDecoration(
        gradient: isActive ? AppColors.bluePurpleGradient : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.labelLarge.copyWith(
            color: isActive ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _TopThreeRanking extends StatelessWidget {
  const _TopThreeRanking();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 282,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Expanded(
            child: _TopRankCard(
              rank: 2,
              name: 'Julian R.',
              xp: '12.4k XP',
              height: 198,
              avatarSize: 70,
              podiumHeight: 64,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _TopRankCard(
              rank: 1,
              name: 'Sarah W.',
              xp: '15.8k XP',
              height: 238,
              avatarSize: 86,
              podiumHeight: 88,
              isChampion: true,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _TopRankCard(
              rank: 3,
              name: 'Marcus T.',
              xp: '11.9k XP',
              height: 184,
              avatarSize: 66,
              podiumHeight: 54,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopRankCard extends StatelessWidget {
  final int rank;
  final String name;
  final String xp;
  final double height;
  final double avatarSize;
  final double podiumHeight;
  final bool isChampion;

  const _TopRankCard({
    required this.rank,
    required this.name,
    required this.xp,
    required this.height,
    required this.avatarSize,
    required this.podiumHeight,
    this.isChampion = false,
  });

  @override
  Widget build(BuildContext context) {
    final rankColor = rank == 1
        ? AppColors.tertiary
        : rank == 2
            ? AppColors.neutral
            : AppColors.secondary;

    return SizedBox(
      height: height,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  gradient: isChampion
                      ? AppColors.goldGradient
                      : AppColors.bluePurpleGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: rankColor.withOpacity(0.25),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: avatarSize * 0.52,
                ),
              ),
              if (isChampion)
                Positioned(
                  top: -22,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: AppColors.tertiary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: AppColors.textPrimary,
                      size: 22,
                    ),
                  ),
                ),
              Positioned(
                bottom: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '#$rank',
                    style: AppTextStyles.caption.copyWith(
                      color: rankColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            name,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            xp,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Container(
            height: podiumHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: isChampion
                  ? AppColors.bluePurpleGradient
                  : LinearGradient(
                      colors: [
                        AppColors.surface,
                        AppColors.surfaceSoft.withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(26),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$rank',
                style: AppTextStyles.headingLarge.copyWith(
                  color: isChampion ? Colors.white : AppColors.textMuted,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final VoidCallback onHomeTap;

  const _BottomNav({
    required this.onHomeTap,
  });

  void _openTab(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.14),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _BottomNavItem(
              icon: Icons.home_rounded,
              label: 'Beranda',
              onTap: onHomeTap,
            ),
          ),
          const Expanded(
            child: _BottomNavItem(
              icon: Icons.emoji_events_rounded,
              label: 'Peringkat',
              isActive: true,
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.person_rounded,
              label: 'User',
              onTap: () => _openTab(context, RouteNames.user),
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.info_rounded,
              label: 'About',
              onTap: () => _openTab(context, RouteNames.aboutDeveloper),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 52,
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.bluePurpleGradient : null,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textMuted,
              size: 21,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: isActive ? Colors.white : AppColors.textMuted,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
