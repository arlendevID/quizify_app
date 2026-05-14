import 'package:flutter/material.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/quiz/dashboard_screen.dart';
import '../screens/quiz/leaderboard_screen.dart';
import '../screens/quiz/quiz_list_screen.dart';
import '../screens/quiz/quiz_screen.dart';
import '../screens/quiz/result_screen.dart';
import 'route_names.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _buildRoute(settings, const SplashScreen());

      case RouteNames.login:
        return _buildRoute(settings, const LoginScreen());

      case RouteNames.register:
        return _buildRoute(settings, const RegisterScreen());

      case RouteNames.dashboard:
        return _buildRoute(settings, const DashboardScreen());

      case RouteNames.quizList:
        return _buildRoute(settings, const QuizListScreen());

      case RouteNames.quiz:
        return _buildRoute(settings, const QuizScreen());

      case RouteNames.result:
        return _buildRoute(settings, const ResultScreen());

      case RouteNames.leaderboard:
        return _buildRoute(settings, const LeaderboardScreen());

      default:
        return _buildRoute(settings, const SplashScreen());
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    RouteSettings settings,
    Widget page,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => page,
    );
  }
}