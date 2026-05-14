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
  int currentIndex = 0;
  final Map<int, int> selectedAnswers = {};

  final List<_QuestionData> questions = const [
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

  int get selectedIndex => selectedAnswers[currentIndex] ?? -1;

  int get correctAnsweredCount {
    int count = 0;

    selectedAnswers.forEach((questionIndex, answerIndex) {
      if (questions[questionIndex].correctIndex == answerIndex) {
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
    final isLastQuestion = currentIndex == questions.length - 1;

    if (isLastQuestion) {
      Navigator.pushReplacementNamed(context, RouteNames.result);
      return;
    }

    setState(() {
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                currentQuestion: currentIndex + 1,
                totalQuestions: questions.length,
                progress: progress,
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  QuizTimer(
                    seconds: 14,
                    progress: 0.72,
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
}

class _QuizHeader extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final double progress;

  const _QuizHeader({
    required this.currentQuestion,
    required this.totalQuestions,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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