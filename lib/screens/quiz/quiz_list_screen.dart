import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/route_names.dart';
import '../../widgets/quiz/quiz_list_tile.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  List<Map<String, dynamic>> _sampleQuestions(String quizTitle) {
    return [
      {
        'question': 'Apa fokus utama dari $quizTitle?',
        'options': ['Konsep dasar', 'Olahraga', 'Musik', 'Kuliner'],
        'correctIndex': 0,
      },
      {
        'question': 'Apa manfaat mengikuti kuis ini?',
        'options': [
          'Mengasah pemahaman',
          'Menghapus data',
          'Mengganti akun',
          'Membuka pengaturan',
        ],
        'correctIndex': 0,
      },
      {
        'question': 'Bagaimana cara mendapatkan skor terbaik?',
        'options': [
          'Menjawab dengan teliti',
          'Melewati semua soal',
          'Menutup aplikasi',
          'Mengabaikan instruksi',
        ],
        'correctIndex': 0,
      },
      {
        'question': 'Apa yang ditampilkan setelah kuis selesai?',
        'options': ['Hasil kuis', 'Halaman login', 'Pengaturan', 'Splash'],
        'correctIndex': 0,
      },
    ];
  }

  void _openQuiz(
    BuildContext context, {
    required _QuizItem quiz,
    required String categoryTitle,
    required Map<String, dynamic> quizListArguments,
  }) {
    final questions = _sampleQuestions(quiz.title);

    Navigator.pushNamed(
      context,
      RouteNames.quiz,
      arguments: {
        'quizTitle': quiz.title,
        'categoryTitle': categoryTitle,
        'source': 'quiz_list',
        'duration': quiz.durationMinutes,
        'totalQuestions': questions.length,
        'questions': questions,
        'quizListArguments': quizListArguments,
      },
    );
  }

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
    final routeArguments = ModalRoute.of(context)?.settings.arguments;
    final categoryData = routeArguments is Map<String, dynamic>
        ? routeArguments
        : const <String, dynamic>{};
    final categoryTitle =
        categoryData['categoryTitle'] as String? ?? 'Teknologi';
    final heroTitle =
        categoryData['heroTitle'] as String? ?? 'Eksplorasi Teknologi';
    final heroDescription = categoryData['heroDescription'] as String? ??
        'Jelajahi dunia teknologi dari AI hingga Hardware. Uji pengetahuanmu dan jadilah master di era digital.';
    final heroIcon = categoryData['heroIcon'] as IconData? ??
        Icons.computer_rounded;
    final heroColor = categoryData['heroColor'] as Color? ?? AppColors.primary;
    final quizListArguments = {
      'categoryTitle': categoryTitle,
      'heroTitle': heroTitle,
      'heroDescription': heroDescription,
      'heroIcon': heroIcon,
      'heroColor': heroColor,
    };

    final quizzes = [
      _QuizItem(
        title: 'Dasar-dasar AI',
        difficulty: 'MUDAH',
        description:
            'Pahami konsep dasar kecerdasan buatan dan bagaimana ia mengubah dunia kita...',
        questionCount: 15,
        durationMinutes: 10,
        icon: Icons.psychology_rounded,
      ),
      _QuizItem(
        title: 'Pemrograman Web',
        difficulty: 'MENENGAH',
        description:
            'Uji kemampuan HTML, CSS, dan JavaScript kamu dalam membangun situ...',
        questionCount: 20,
        durationMinutes: 15,
        icon: Icons.code_rounded,
      ),
      _QuizItem(
        title: 'Keamanan Siber',
        difficulty: 'SULIT',
        description:
            'Pelajari cara melindungi data dan sistem dari ancaman digital. Quiz ini mencakup enkripsi, firewall, dan etika hacking.',
        questionCount: 25,
        durationMinutes: 20,
        icon: Icons.security_rounded,
      ),
      _QuizItem(
        title: 'Cloud Computing',
        difficulty: 'MENENGAH',
        description: 'AWS, Azure, dan Google Cloud Platform.',
        questionCount: 18,
        durationMinutes: 12,
        icon: Icons.cloud_rounded,
      ),
      _QuizItem(
        title: 'Internet of Things',
        difficulty: 'MUDAH',
        description: 'Menghubungkan dunia fisik ke internet.',
        questionCount: 12,
        durationMinutes: 8,
        icon: Icons.sensors_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 116),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _QuizListHeader(
                    title: categoryTitle,
                    color: heroColor,
                    onBackTap: () => _goBackToDashboard(context),
                  ),
                  const SizedBox(height: 24),
                  _HeroCategoryCard(
                    title: heroTitle,
                    description: heroDescription,
                    icon: heroIcon,
                    color: heroColor,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Pilih Tantangan',
                    style: AppTextStyles.headingMedium.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quizzes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final quiz = quizzes[index];

                      return QuizListTile(
                        title: quiz.title,
                        description: quiz.description,
                        difficulty: quiz.difficulty,
                        questionCount: quiz.questionCount,
                        icon: quiz.icon,
                        onTap: () => _openQuiz(
                          context,
                          quiz: quiz,
                          categoryTitle: categoryTitle,
                          quizListArguments: quizListArguments,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 18,
              child: _FloatingBottomNav(
                onHomeTap: () => _goBackToDashboard(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizItem {
  final String title;
  final String difficulty;
  final String description;
  final int questionCount;
  final int durationMinutes;
  final IconData icon;

  const _QuizItem({
    required this.title,
    required this.difficulty,
    required this.description,
    required this.questionCount,
    required this.durationMinutes,
    required this.icon,
  });
}

class _QuizListHeader extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onBackTap;

  const _QuizListHeader({
    required this.title,
    required this.color,
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: onBackTap,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.headingLarge.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
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
            'Lv. 12',
            style: AppTextStyles.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                Color.lerp(color, Colors.black, 0.22) ?? color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }
}

class _HeroCategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _HeroCategoryCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            Color.lerp(color, Colors.black, 0.22) ?? color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -22,
            bottom: -22,
            child: Icon(
              Icons.memory_rounded,
              color: Colors.white.withOpacity(0.12),
              size: 138,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 94,
                  height: 94,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.24),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                title,
                style: AppTextStyles.headingLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.82),
                  height: 1.55,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FloatingBottomNav extends StatelessWidget {
  final VoidCallback onHomeTap;

  const _FloatingBottomNav({
    required this.onHomeTap,
  });

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
              label: 'Home',
              isActive: true,
              onTap: onHomeTap,
            ),
          ),
          const Expanded(
            child: _BottomNavItem(
              icon: Icons.emoji_events_rounded,
              label: 'Ranks',
            ),
          ),
          const Expanded(
            child: _BottomNavItem(
              icon: Icons.person_rounded,
              label: 'Profile',
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textMuted,
              size: 22,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
