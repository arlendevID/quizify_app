import 'package:flutter/material.dart';

import 'constants/app_strings.dart';
import 'constants/app_text_styles.dart';
import 'routes/app_routes.dart';
import 'routes/route_names.dart';

class QuizifyApp extends StatelessWidget {
  const QuizifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}