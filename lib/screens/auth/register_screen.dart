import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/route_names.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleRegister() {
    Navigator.pushReplacementNamed(
      context,
      RouteNames.login,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _OnlineBadge(),
                    const SizedBox(height: 22),
                    Text(
                      'Buat akun baru,\ncalon Quizmaster!',
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Kumpulkan XP, selesaikan quest, dan mulai perjalanan belajarmu.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const _HeroIllustration(),
                    const SizedBox(height: 24),
                    _SegmentedAuthTab(
                      activeIndex: 1,
                      onLoginTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteNames.login,
                        );
                      },
                      onRegisterTap: () {},
                    ),
                    const SizedBox(height: 22),
                    CustomButton(
                      text: 'Daftar dengan Google',
                      icon: Icons.g_mobiledata_rounded,
                      onPressed: () {},
                      type: QuizifyButtonType.outlined,
                    ),
                    const SizedBox(height: 22),
                    const _EmailDivider(),
                    const SizedBox(height: 22),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Nama lengkap',
                      prefixIcon: const Icon(
                        Icons.person_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.email_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      prefixIcon: const Icon(
                        Icons.lock_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Buat Akun →',
                      onPressed: _handleRegister,
                      type: QuizifyButtonType.primary,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Dengan daftar, kamu menyetujui Terms & Privacy Quizify.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OnlineBadge extends StatelessWidget {
  const _OnlineBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '1.240 pemain online sekarang',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroIllustration extends StatelessWidget {
  const _HeroIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.bluePurpleGradient,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.22),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            top: -26,
            child: _BlurCircle(
              size: 118,
              color: Colors.white.withOpacity(0.18),
            ),
          ),
          Positioned(
            left: -18,
            bottom: -22,
            child: _BlurCircle(
              size: 96,
              color: AppColors.tertiary.withOpacity(0.24),
            ),
          ),
          Positioned(
            right: 24,
            bottom: 24,
            child: Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.22),
                ),
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: AppColors.tertiary,
                size: 46,
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 26,
            child: Text(
              'Start Journey',
              style: AppTextStyles.headingSmall.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 62,
            child: Text(
              'Buat profil dan mulai\nquest pertamamu.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.82),
              ),
            ),
          ),
          Positioned(
            left: 24,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white.withOpacity(0.22),
                ),
              ),
              child: Text(
                'Bonus +500 XP',
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SegmentedAuthTab extends StatelessWidget {
  final int activeIndex;
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;

  const _SegmentedAuthTab({
    required this.activeIndex,
    required this.onLoginTap,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentItem(
              title: 'Masuk',
              isActive: activeIndex == 0,
              onTap: onLoginTap,
            ),
          ),
          Expanded(
            child: _SegmentItem(
              title: 'Daftar',
              isActive: activeIndex == 1,
              onTap: onRegisterTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _SegmentItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 46,
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.bluePurpleGradient : null,
          color: isActive ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
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
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailDivider extends StatelessWidget {
  const _EmailDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'ATAU EMAIL',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textMuted,
              letterSpacing: 1,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.divider)),
      ],
    );
  }
}