import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/route_names.dart';
import '../../widgets/dashboard/category_card.dart';
import '../../widgets/dashboard/quiz_recommendation_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _goToQuizList(
    BuildContext context, {
    required String categoryTitle,
    required String heroTitle,
    required String heroDescription,
    required IconData heroIcon,
    required Color heroColor,
  }) {
    Navigator.pushNamed(
      context,
      RouteNames.quizList,
      arguments: {
        'categoryTitle': categoryTitle,
        'heroTitle': heroTitle,
        'heroDescription': heroDescription,
        'heroIcon': heroIcon,
        'heroColor': heroColor,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header(),
                  const SizedBox(height: 24),
                  const _XpProgressCard(),
                  const SizedBox(height: 18),
                  const _StatsRow(),
                  const SizedBox(height: 28),

                  _SectionHeader(
                    title: 'Rekomendasi Untukmu',
                    actionText: '',
                    onTap: () => _goToQuizList(
                      context,
                      categoryTitle: 'Teknologi',
                      heroTitle: 'Eksplorasi Teknologi',
                      heroDescription:
                          'Jelajahi dunia teknologi dari AI hingga Hardware. Uji pengetahuanmu dan jadilah master di era digital.',
                      heroIcon: Icons.computer_rounded,
                      heroColor: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 178,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        QuizRecommendationCard(
                          title: 'Garis Depan Siber',
                          badge: 'PALING POPULER',
                          questionCount: 24,
                          estimatedMinutes: 18,
                          icon: Icons.security_rounded,
                          gradient: AppColors.bluePurpleGradient,
                          onTap: () => _goToQuizList(
                            context,
                            categoryTitle: 'Keamanan Siber',
                            heroTitle: 'Garis Depan Siber',
                            heroDescription:
                                'Pelajari cara melindungi data dan sistem dari ancaman digital melalui tantangan keamanan siber.',
                            heroIcon: Icons.security_rounded,
                            heroColor: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 14),
                        QuizRecommendationCard(
                          title: 'Kalkulus Lanjutan',
                          badge: 'TANTANGAN HARIAN',
                          questionCount: 18,
                          estimatedMinutes: 15,
                          icon: Icons.functions_rounded,
                          gradient: AppColors.goldGradient,
                          darkText: true,
                          onTap: () => _goToQuizList(
                            context,
                            categoryTitle: 'Matematika',
                            heroTitle: 'Kalkulus Lanjutan',
                            heroDescription:
                                'Asah logika dan pemahaman rumus melalui kuis matematika yang menantang.',
                            heroIcon: Icons.functions_rounded,
                            heroColor: AppColors.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  _SectionHeader(
                    title: 'Kategori Kuis',
                    actionText: '',
                    onTap: () {},
                  ),

                  const SizedBox(height: 16),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.08,
                    children: [
                      CategoryCard(
                        title: 'Teknologi',
                        quizCount: 32,
                        icon: Icons.computer_rounded,
                        color: AppColors.primary,
                        onTap: () => _goToQuizList(
                          context,
                          categoryTitle: 'Teknologi',
                          heroTitle: 'Eksplorasi Teknologi',
                          heroDescription:
                              'Jelajahi dunia teknologi dari AI hingga Hardware. Uji pengetahuanmu dan jadilah master di era digital.',
                          heroIcon: Icons.computer_rounded,
                          heroColor: AppColors.primary,
                        ),
                      ),
                      CategoryCard(
                        title: 'Umum',
                        quizCount: 21,
                        icon: Icons.public_rounded,
                        color: AppColors.secondary,
                        onTap: () => _goToQuizList(
                          context,
                          categoryTitle: 'Umum',
                          heroTitle: 'Pengetahuan Umum',
                          heroDescription:
                              'Uji wawasan luasmu dari topik sehari-hari, budaya, dunia, dan fakta menarik lainnya.',
                          heroIcon: Icons.public_rounded,
                          heroColor: AppColors.secondary,
                        ),
                      ),
                      CategoryCard(
                        title: 'Bahasa',
                        quizCount: 18,
                        icon: Icons.translate_rounded,
                        color: AppColors.tertiary,
                        darkText: true,
                        onTap: () => _goToQuizList(
                          context,
                          categoryTitle: 'Bahasa',
                          heroTitle: 'Eksplorasi Bahasa',
                          heroDescription:
                              'Latih kosakata, tata bahasa, dan kemampuan memahami bahasa lewat tantangan singkat.',
                          heroIcon: Icons.translate_rounded,
                          heroColor: AppColors.tertiary,
                        ),
                      ),
                      CategoryCard(
                        title: 'Matematika',
                        quizCount: 27,
                        icon: Icons.calculate_rounded,
                        color: Color(0xFF22C55E),
                        onTap: () => _goToQuizList(
                          context,
                          categoryTitle: 'Matematika',
                          heroTitle: 'Tantangan Matematika',
                          heroDescription:
                              'Asah kemampuan berhitung, logika, dan pemecahan masalah dalam kuis matematika.',
                          heroIcon: Icons.calculate_rounded,
                          heroColor: const Color(0xFF22C55E),
                        ),
                      ),
                    ],
                  ),
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
            Icons.bolt_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Quizify',
          style: AppTextStyles.headingLarge.copyWith(
            fontWeight: FontWeight.w800,
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
            ),
          ),
        ),
      ],
    );
  }
}

class _XpProgressCard extends StatelessWidget {
  const _XpProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.bluePurpleGradient,
        borderRadius: BorderRadius.circular(36),
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
            right: -18,
            bottom: -18,
            child: Icon(
              Icons.emoji_events_rounded,
              size: 132,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'YB Saat Ini',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.78),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '12,450 XP',
                style: AppTextStyles.displayLarge.copyWith(
                  color: Colors.white,
                  fontSize: 38,
                ),
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: 0.72,
                  minHeight: 12,
                  backgroundColor: Colors.white.withOpacity(0.22),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.tertiary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '850 XP menuju Level 13',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.82),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StatCard(
            value: '27',
            label: 'Quiz Selesai',
            icon: Icons.quiz_rounded,
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: _StatCard(
            value: '#42',
            label: 'Peringkat Global',
            icon: Icons.leaderboard_rounded,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: AppTextStyles.headingSmall),
                const SizedBox(height: 3),
                Text(label, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onTap;

  const _SectionHeader({
    required this.title,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.headingMedium),
        const Spacer(),
        if (actionText.isNotEmpty)
          TextButton(
            onPressed: onTap,
            child: Text(actionText),
          ),
      ],
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
          const Expanded(
            child: _BottomNavItem(
              icon: Icons.home_rounded,
              label: 'Beranda',
              isActive: true,
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.emoji_events_rounded,
              label: 'Peringkat',
              onTap: () => _openTab(context, RouteNames.leaderboard),
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
