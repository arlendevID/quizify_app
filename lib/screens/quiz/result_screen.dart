import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/route_names.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/result/answer_review_card.dart';
import '../../widgets/result/score_summary_card.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool showReview = false;
  bool hasLoadedArguments = false;

  String quizTitle = 'Quiz';
  int totalQuestions = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int scorePercentage = 0;
  Map<String, dynamic> quizListArguments = const <String, dynamic>{};
  List<_AnswerReviewData> reviewData = const [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (hasLoadedArguments) {
      return;
    }

    final routeArguments = ModalRoute.of(context)?.settings.arguments;

    if (routeArguments is Map<String, dynamic>) {
      quizTitle = routeArguments['quizTitle'] as String? ?? quizTitle;
      totalQuestions = routeArguments['totalQuestions'] as int? ?? 0;
      correctAnswers = routeArguments['correctAnswers'] as int? ?? 0;
      wrongAnswers = routeArguments['wrongAnswers'] as int? ?? 0;
      scorePercentage = routeArguments['scorePercentage'] as int? ?? 0;
      final rawQuizListArguments = routeArguments['quizListArguments'];
      if (rawQuizListArguments is Map<String, dynamic>) {
        quizListArguments = rawQuizListArguments;
      }
      reviewData = _buildReviewData(
        routeArguments['questions'],
        routeArguments['selectedAnswers'],
      );
    }

    hasLoadedArguments = true;
  }

  void _goBackToQuizList() {
    var quizListFound = false;

    Navigator.popUntil(context, (route) {
      if (route.settings.name == RouteNames.quizList) {
        quizListFound = true;
        return true;
      }

      return route.isFirst;
    });

    if (!quizListFound) {
      Navigator.pushReplacementNamed(
        context,
        RouteNames.quizList,
        arguments: quizListArguments,
      );
    }
  }

  void _goBackToDashboard() {
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

  List<_AnswerReviewData> _buildReviewData(
    dynamic rawQuestions,
    dynamic rawSelectedAnswers,
  ) {
    if (rawQuestions is! List) {
      return const [];
    }

    final selectedAnswers = <int, int>{};
    if (rawSelectedAnswers is Map) {
      rawSelectedAnswers.forEach((key, value) {
        final questionIndex = key is int ? key : int.tryParse('$key');
        if (questionIndex != null && value is int) {
          selectedAnswers[questionIndex] = value;
        }
      });
    }

    final reviews = <_AnswerReviewData>[];

    for (var index = 0; index < rawQuestions.length; index++) {
      final item = rawQuestions[index];

      if (item is! Map) {
        continue;
      }

      final questionText = item['question'];
      final options = item['options'];
      final correctIndex = item['correctIndex'];

      if (questionText is! String ||
          options is! List ||
          correctIndex is! int) {
        continue;
      }

      final parsedOptions = options.whereType<String>().toList();
      if (correctIndex < 0 || correctIndex >= parsedOptions.length) {
        continue;
      }

      final selectedIndex = selectedAnswers[index];
      final hasSelectedAnswer = selectedIndex != null &&
          selectedIndex >= 0 &&
          selectedIndex < parsedOptions.length;
      final userAnswer = hasSelectedAnswer
          ? parsedOptions[selectedIndex]
          : 'Tidak dijawab';

      reviews.add(
        _AnswerReviewData(
          questionNumber: index + 1,
          questionText: questionText,
          userAnswer: userAnswer,
          correctAnswer: parsedOptions[correctIndex],
          isCorrect: selectedIndex == correctIndex,
        ),
      );
    }

    return reviews;
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
                  const _CelebrationSection(),
                  const SizedBox(height: 20),
                  _ScoreCard(
                    quizTitle: quizTitle,
                    scorePercentage: scorePercentage,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ScoreSummaryCard(
                          title: 'Akurasi',
                          value: '$scorePercentage%',
                          icon: Icons.track_changes_rounded,
                          iconColor: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: ScoreSummaryCard(
                          title: 'Benar',
                          value: '$correctAnswers/$totalQuestions',
                          icon: Icons.check_circle_rounded,
                          iconColor: AppColors.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  _PerformanceDetail(
                    totalQuestions: totalQuestions,
                    correctAnswers: correctAnswers,
                    wrongAnswers: wrongAnswers,
                  ),
                  const SizedBox(height: 20),
                  const _LevelUpCard(),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Main Lagi',
                    onPressed: _goBackToQuizList,
                    type: QuizifyButtonType.primary,
                  ),
                  const SizedBox(height: 14),
                  CustomButton(
                    text: 'Kembali ke Dashboard',
                    onPressed: _goBackToDashboard,
                    type: QuizifyButtonType.outlined,
                  ),
                  const SizedBox(height: 14),
                  CustomButton(
                    text: showReview ? 'Sembunyikan Review' : 'Tinjau Jawaban',
                    onPressed: () {
                      setState(() {
                        showReview = !showReview;
                      });
                    },
                    type: QuizifyButtonType.outlined,
                  ),
                  if (showReview) ...[
                    const SizedBox(height: 28),
                    Text(
                      'Review Jawaban',
                      style: AppTextStyles.headingMedium.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (reviewData.isEmpty)
                      Text(
                        'Data review belum tersedia.',
                        style: AppTextStyles.bodyMedium,
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviewData.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final item = reviewData[index];

                          return AnswerReviewCard(
                            questionNumber: item.questionNumber,
                            questionText: item.questionText,
                            userAnswer: item.userAnswer,
                            correctAnswer: item.correctAnswer,
                            isCorrect: item.isCorrect,
                          );
                        },
                      ),
                  ],
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

class _CelebrationSection extends StatelessWidget {
  const _CelebrationSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.09),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.tertiary,
                  size: 46,
                ),
              ),
              Positioned(
                right: -44,
                top: 4,
                child: Transform.rotate(
                  angle: 0.12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'LUAR BIASA!',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Kuis Selesai',
            style: AppTextStyles.displayMedium.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kamu semakin hebat setiap hari!',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String quizTitle;
  final int scorePercentage;

  const _ScoreCard({
    required this.quizTitle,
    required this.scorePercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
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
      child: Stack(
        children: [
          Positioned(
            right: -18,
            bottom: -28,
            child: Icon(
              Icons.emoji_events_rounded,
              size: 130,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quizTitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.80),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$scorePercentage%',
                style: AppTextStyles.displayLarge.copyWith(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PerformanceDetail extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;

  const _PerformanceDetail({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final correctProgress = totalQuestions == 0
        ? 0.0
        : (correctAnswers / totalQuestions).clamp(0.0, 1.0);
    final wrongProgress = totalQuestions == 0
        ? 0.0
        : (wrongAnswers / totalQuestions).clamp(0.0, 1.0);

    return Container(
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
          Text('Rincian Performa', style: AppTextStyles.headingSmall),
          const SizedBox(height: 18),
          _PerformanceBar(
            label: 'Jawaban Benar',
            value: '$correctAnswers/$totalQuestions',
            progress: correctProgress,
            color: AppColors.primary,
          ),
          const SizedBox(height: 18),
          _PerformanceBar(
            label: 'Kesalahan',
            value: '$wrongAnswers',
            progress: wrongProgress,
            color: AppColors.error,
          ),
        ],
      ),
    );
  }
}

class _PerformanceBar extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color color;

  const _PerformanceBar({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(label, style: AppTextStyles.labelLarge),
            const Spacer(),
            Text(
              value,
              style: AppTextStyles.labelLarge.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: AppColors.surfaceSoft,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _LevelUpCard extends StatelessWidget {
  const _LevelUpCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.20),
          width: 1.4,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: AppColors.bluePurpleGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.upgrade_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Naik Level!', style: AppTextStyles.headingSmall),
                const SizedBox(height: 6),
                Text(
                  'Kamu telah mencapai Level 13. Teruslah bermain untuk membuka kategori baru!',
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

class _BottomNav extends StatelessWidget {
  const _BottomNav();

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
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.dashboard,
                );
              },
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.emoji_events_rounded,
              label: 'Ranks',
              onTap: () {
                Navigator.pushNamed(context, RouteNames.leaderboard);
              },
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

class _AnswerReviewData {
  final int questionNumber;
  final String questionText;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const _AnswerReviewData({
    required this.questionNumber,
    required this.questionText,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });
}
