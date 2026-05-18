import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/route_names.dart';
import '../../widgets/common/custom_button.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 144),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Header(),
                  SizedBox(height: 24),
                  _ProfileCard(),
                  SizedBox(height: 20),
                  _StatsGrid(),
                  SizedBox(height: 20),
                  _RankCard(),
                  SizedBox(height: 22),
                  _LogoutCard(),
                ],
              ),
            ),
            const Positioned(
              left: 22,
              right: 22,
              bottom: 18,
              child: _BottomNav(),
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
            Icons.person_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'User',
          style: AppTextStyles.headingLarge.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.bluePurpleGradient,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            bottom: -30,
            child: Icon(
              Icons.bolt_rounded,
              size: 132,
              color: Colors.white.withOpacity(0.10),
            ),
          ),
          Row(
            children: [
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arlen Quizmaster',
                      style: AppTextStyles.headingLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'arlen@example.com',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.78),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.20),
                        ),
                      ),
                      child: Text(
                        'Level 12 Quizmaster',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StatCard(
            title: 'Total XP',
            value: '12,450',
            icon: Icons.bolt_rounded,
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: _StatCard(
            title: 'Quiz Selesai',
            value: '27',
            icon: Icons.quiz_rounded,
          ),
        ),
      ],
    );
  }
}

class _RankCard extends StatelessWidget {
  const _RankCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.textPrimary,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('#42 Global', style: AppTextStyles.headingSmall),
                const SizedBox(height: 4),
                Text(
                  'Peringkat minggu ini',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const Spacer(),
          Text(value, style: AppTextStyles.headingSmall),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}

class _LogoutCard extends StatelessWidget {
  const _LogoutCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: CustomButton(
        text: 'Logout',
        icon: Icons.logout_rounded,
        onPressed: () {},
        type: QuizifyButtonType.outlined,
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

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
              onTap: () => _openTab(context, RouteNames.dashboard),
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.emoji_events_rounded,
              label: 'Peringkat',
              onTap: () => _openTab(context, RouteNames.leaderboard),
            ),
          ),
          const Expanded(
            child: _BottomNavItem(
              icon: Icons.person_rounded,
              label: 'User',
              isActive: true,
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
