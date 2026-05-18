import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/route_names.dart';

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

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
                children: const [
                  _Header(),
                  SizedBox(height: 26),
                  _TeamHeroCard(),
                  SizedBox(height: 18),
                  _TeamSection(),
                  SizedBox(height: 18),
                  _AboutQuizifyCard(),
                  SizedBox(height: 18),
                  _TechStackCard(),
                  SizedBox(height: 18),
                  _VersionCard(),
                  SizedBox(height: 18),
                  _ContactCard(),
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
            Icons.info_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Tentang Tim',
          style: AppTextStyles.headingLarge.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _TeamHeroCard extends StatelessWidget {
  const _TeamHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Row(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.groups_rounded,
              color: Colors.white,
              size: 42,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meet The Team',
                  style: AppTextStyles.headingMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Tim pengembang yang membangun pengalaman Quizify dari desain layar, flow navigasi, hingga fondasi aplikasi.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.78),
                    height: 1.35,
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

class _TeamSection extends StatelessWidget {
  const _TeamSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SectionTitle(title: 'Tim Pengembang'),
        SizedBox(height: 14),
        _TeamMemberCard(
          icon: Icons.phone_iphone_rounded,
          name: 'Arlen P Dinova',
          role: 'Flutter Developer / Informatics Student',
          description:
              'Merancang antarmuka Quizify, menyusun navigasi utama, dan membangun flow aplikasi agar mudah digunakan.',
          accentColor: AppColors.primary,
        ),
        SizedBox(height: 14),
        _TeamMemberCard(
          icon: Icons.palette_rounded,
          name: 'UI Contributor',
          role: 'Interface Designer',
          description:
              'Merapikan komposisi visual, spacing, warna, dan card agar tampilan Quizify tetap modern dan konsisten.',
          accentColor: AppColors.secondary,
        ),
        SizedBox(height: 14),
        _TeamMemberCard(
          icon: Icons.school_rounded,
          name: 'Learning Content Contributor',
          role: 'Quiz Content Support',
          description:
              'Membantu menyiapkan kategori, data dummy, dan struktur konten quiz untuk kebutuhan demonstrasi aplikasi.',
          accentColor: AppColors.tertiary,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.headingMedium.copyWith(
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String role;
  final String description;
  final Color accentColor;

  const _TeamMemberCard({
    required this.icon,
    required this.name,
    required this.role,
    required this.description,
    required this.accentColor,
  });

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
            color: accentColor.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: accentColor.withOpacity(0.20),
              ),
            ),
            child: Icon(icon, color: accentColor, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.headingSmall),
                const SizedBox(height: 5),
                Text(
                  role,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
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

class _AboutQuizifyCard extends StatelessWidget {
  const _AboutQuizifyCard();

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Quizify',
      icon: Icons.bolt_rounded,
      child: Text(
        'Quizify adalah aplikasi quiz pembelajaran yang membantu pengguna memilih kategori, menyelesaikan tantangan, dan melihat progres XP secara sederhana.',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
    );
  }
}

class _TechStackCard extends StatelessWidget {
  const _TechStackCard();

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Tech Stack',
      icon: Icons.layers_rounded,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: const [
          _StackChip(label: 'Flutter'),
          _StackChip(label: 'Dart'),
        ],
      ),
    );
  }
}

class _VersionCard extends StatelessWidget {
  const _VersionCard();

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Versi Aplikasi',
      icon: Icons.verified_rounded,
      child: Text(
        '1.0.0',
        style: AppTextStyles.headingSmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Kontak',
      icon: Icons.alternate_email_rounded,
      child: Column(
        children: const [
          _ContactRow(
            icon: Icons.code_rounded,
            label: 'GitHub',
            value: 'github.com/arlen-placeholder',
          ),
          SizedBox(height: 12),
          _ContactRow(
            icon: Icons.email_rounded,
            label: 'Email',
            value: 'arlen@example.com',
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.labelMedium),
              const SizedBox(height: 3),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
              Icon(icon, color: AppColors.primary, size: 26),
              const SizedBox(width: 10),
              Text(title, style: AppTextStyles.headingSmall),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _StackChip extends StatelessWidget {
  final String label;

  const _StackChip({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.16),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
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
          Expanded(
            child: _BottomNavItem(
              icon: Icons.person_rounded,
              label: 'User',
              onTap: () => _openTab(context, RouteNames.user),
            ),
          ),
          const Expanded(
            child: _BottomNavItem(
              icon: Icons.info_rounded,
              label: 'About',
              isActive: true,
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
