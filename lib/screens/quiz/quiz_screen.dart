import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/route_names.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/quiz/answer_option_tile.dart';
import '../../widgets/quiz/question_card.dart';
import '../../widgets/quiz/quiz_timer.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const int secondsPerQuestion = 14;

  int currentIndex = 0;
  String quizTitle = 'Quiz';
  String categoryTitle = 'Umum';
  int durationMinutes = 10;
  bool hasLoadedArguments = false;
  bool isSubmitting = false;
  int remainingSeconds = secondsPerQuestion;
  Timer? questionTimer;
  Map<String, dynamic> quizListArguments = const <String, dynamic>{};
  final Map<int, int> selectedAnswers = {};
  final Set<int> evaluatedQuestions = {};

  List<_QuestionData> questions = const [];

  static const List<_QuestionData> fallbackQuestions = [
    _QuestionData(
      question:
          'Benda langit apa yang menjadi pusat tata surya kita?',
      options: ['Bumi', 'Matahari', 'Bulan', 'Mars'],
      correctIndex: 1,
    ),
    _QuestionData(
      question:
          'Planet terbesar di tata surya kita adalah?',
      options: ['Mars', 'Venus', 'Jupiter', 'Saturnus'],
      correctIndex: 2,
    ),
    _QuestionData(
      question:
          "Planet mana di tata surya kita yang dikenal sebagai 'Planet Merah' karena permukaan oksida besinya?",
      options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      correctIndex: 1,
    ),
    _QuestionData(
      question:
          'Planet yang memiliki cincin paling terkenal adalah?',
      options: ['Merkurius', 'Saturn', 'Bumi', 'Neptunus'],
      correctIndex: 1,
    ),
    _QuestionData(
      question:
          'Satelit alami bumi disebut?',
      options: ['Bulan', 'Matahari', 'Asteroid', 'Komet'],
      correctIndex: 0,
    ),
    _QuestionData(
      question:
          'Planet yang paling dekat dengan Matahari adalah?',
      options: ['Venus', 'Merkurius', 'Mars', 'Bumi'],
      correctIndex: 1,
    ),
    _QuestionData(
      question:
          'Galaksi tempat tata surya kita berada adalah?',
      options: ['Andromeda', 'Bima Sakti', 'Sombrero', 'Triangulum'],
      correctIndex: 1,
    ),
    _QuestionData(
      question:
          'Alat yang digunakan untuk mengamati benda langit adalah?',
      options: ['Mikroskop', 'Teleskop', 'Barometer', 'Termometer'],
      correctIndex: 1,
    ),
    _QuestionData(
      question:
          'Planet yang dikenal sebagai planet biru adalah?',
      options: ['Bumi', 'Mars', 'Venus', 'Uranus'],
      correctIndex: 0,
    ),
    _QuestionData(
      question:
          'Benda langit yang mengelilingi planet disebut?',
      options: ['Satelit', 'Meteor', 'Komet', 'Nebula'],
      correctIndex: 0,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (hasLoadedArguments) {
      return;
    }

    final routeArguments = ModalRoute.of(context)?.settings.arguments;

    if (routeArguments is Map<String, dynamic>) {
      quizTitle = routeArguments['quizTitle'] as String? ?? quizTitle;
      categoryTitle =
          routeArguments['categoryTitle'] as String? ?? categoryTitle;
      durationMinutes = routeArguments['duration'] as int? ?? durationMinutes;
      final rawQuizListArguments = routeArguments['quizListArguments'];
      if (rawQuizListArguments is Map<String, dynamic>) {
        quizListArguments = rawQuizListArguments;
      }
      questions = _parseQuestions(routeArguments['questions']);
    } else {
      questions = fallbackQuestions;
    }

    hasLoadedArguments = true;

    if (questions.isNotEmpty) {
      _resetQuestionTimer();
    }
  }

  List<_QuestionData> _parseQuestions(dynamic rawQuestions) {
    if (rawQuestions is! List) {
      return const [];
    }

    return rawQuestions
        .whereType<Map>()
        .map((item) {
          final question = item['question'];
          final options = item['options'];
          final correctIndex = item['correctIndex'];

          if (question is! String ||
              options is! List ||
              correctIndex is! int) {
            return null;
          }

          final parsedOptions = options.whereType<String>().toList();
          final isCorrectIndexValid =
              correctIndex >= 0 && correctIndex < parsedOptions.length;

          if (parsedOptions.isEmpty || !isCorrectIndexValid) {
            return null;
          }

          return _QuestionData(
            question: question,
            options: parsedOptions,
            correctIndex: correctIndex,
          );
        })
        .whereType<_QuestionData>()
        .toList();
  }

  int get selectedIndex => selectedAnswers[currentIndex] ?? -1;

  int get correctAnsweredCount {
    int count = 0;

    selectedAnswers.forEach((questionIndex, answerIndex) {
      if (evaluatedQuestions.contains(questionIndex) &&
          questionIndex < questions.length &&
          questions[questionIndex].correctIndex == answerIndex) {
        count++;
      }
    });

    return count;
  }

  void _selectAnswer(int index) {
    setState(() {
      selectedAnswers[currentIndex] = index;
    });
  }

  void _goNext() {
    if (questions.isEmpty) {
      return;
    }

    _completeCurrentQuestion();
  }

  void _completeCurrentQuestion() {
    questionTimer?.cancel();
    evaluatedQuestions.add(currentIndex);

    final isLastQuestion = currentIndex == questions.length - 1;

    if (isLastQuestion) {
      _submitQuiz();
      return;
    }

    setState(() {
      currentIndex++;
      remainingSeconds = secondsPerQuestion;
    });

    _resetQuestionTimer();
  }

  void _handleTimeExpired() {
    if (!mounted || isSubmitting || questions.isEmpty) {
      return;
    }

    selectedAnswers.remove(currentIndex);
    _completeCurrentQuestion();
  }

  void _resetQuestionTimer() {
    questionTimer?.cancel();

    questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (isSubmitting || questions.isEmpty) {
        timer.cancel();
        return;
      }

      if (remainingSeconds <= 1) {
        timer.cancel();
        _handleTimeExpired();
        return;
      }

      setState(() {
        remainingSeconds--;
      });
    });
  }

  void _submitQuiz() {
    if (isSubmitting || !mounted) {
      return;
    }

    isSubmitting = true;
    questionTimer?.cancel();

    Navigator.pushReplacementNamed(
      context,
      RouteNames.result,
      arguments: _buildResultArguments(),
    );
  }

  Map<String, dynamic> _buildResultArguments() {
    final totalQuestions = questions.length;
    final correctAnswers = correctAnsweredCount;
    final wrongAnswers = totalQuestions - correctAnswers;
    final scorePercentage = totalQuestions == 0
        ? 0
        : ((correctAnswers / totalQuestions) * 100).round();

    return {
      'quizTitle': quizTitle,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'scorePercentage': scorePercentage,
      'selectedAnswers': Map<int, int>.from(selectedAnswers),
      'quizListArguments': quizListArguments,
      'questions': questions
          .map(
            (question) => {
              'question': question.question,
              'options': question.options,
              'correctIndex': question.correctIndex,
            },
          )
          .toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return _EmptyQuizState(
        quizTitle: quizTitle,
        categoryTitle: categoryTitle,
      );
    }

    final question = questions[currentIndex];
    final progress = (currentIndex + 1) / questions.length;
    final isLastQuestion = currentIndex == questions.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _QuizHeader(
                quizTitle: quizTitle,
                categoryTitle: categoryTitle,
                currentQuestion: currentIndex + 1,
                totalQuestions: questions.length,
                durationMinutes: durationMinutes,
                progress: progress,
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  QuizTimer(
                    seconds: remainingSeconds,
                    progress: remainingSeconds / secondsPerQuestion,
                    size: 82,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              QuestionCard(
                questionText: question.question,
              ),

              const SizedBox(height: 26),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: question.options.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  return AnswerOptionTile(
                    label: String.fromCharCode(65 + index),
                    answerText: question.options[index],
                    isSelected: selectedIndex == index,
                    showCheckIcon: selectedIndex == index,
                    onTap: () => _selectAnswer(index),
                  );
                },
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(22),
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
                          '$correctAnsweredCount Benar',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 7,
                    child: CustomButton(
                      text: isLastQuestion
                          ? 'Submit Quiz'
                          : 'Pertanyaan Berikutnya',
                      onPressed: selectedIndex == -1 ? null : _goNext,
                      type: QuizifyButtonType.primary,
                      height: 56,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    questionTimer?.cancel();
    super.dispose();
  }
}

class _QuizHeader extends StatelessWidget {
  final String quizTitle;
  final String categoryTitle;
  final int currentQuestion;
  final int totalQuestions;
  final int durationMinutes;
  final double progress;

  const _QuizHeader({
    required this.quizTitle,
    required this.categoryTitle,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.durationMinutes,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          quizTitle,
          style: AppTextStyles.headingLarge.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$categoryTitle - $durationMinutes menit',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'PERTANYAAN $currentQuestion DARI $totalQuestions',
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: AppColors.surfaceSoft,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyQuizState extends StatelessWidget {
  final String quizTitle;
  final String categoryTitle;

  const _EmptyQuizState({
    required this.quizTitle,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quizTitle,
                style: AppTextStyles.headingLarge.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                categoryTitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
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
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.10),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.error_outline_rounded,
                        color: AppColors.error,
                        size: 38,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Pertanyaan belum tersedia',
                      style: AppTextStyles.headingSmall.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Quiz ini belum memiliki data pertanyaan yang valid.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 22),
                    CustomButton(
                      text: 'Kembali',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      type: QuizifyButtonType.outlined,
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionData {
  final String question;
  final List<String> options;
  final int correctIndex;

  const _QuestionData({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}
