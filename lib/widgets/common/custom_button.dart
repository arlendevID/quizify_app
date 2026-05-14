import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

enum QuizifyButtonType {
  primary,
  secondary,
  outlined,
  glass,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final QuizifyButtonType type;
  final IconData? icon;
  final bool isLoading;
  final double height;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = QuizifyButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.height = 58,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return Opacity(
      opacity: isDisabled ? 0.6 : 1,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            width: double.infinity,
            height: height,
            padding: padding,
            decoration: _buildDecoration(),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: _loadingColor(),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            size: 20,
                            color: _textColor(),
                          ),
                          const SizedBox(width: 10),
                        ],
                        Flexible(
                          child: Text(
                            text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.button.copyWith(
                              color: _textColor(),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    switch (type) {
      case QuizifyButtonType.primary:
        return BoxDecoration(
          gradient: AppColors.bluePurpleGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [AppColors.cardShadow],
        );

      case QuizifyButtonType.secondary:
        return BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.tertiary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        );

      case QuizifyButtonType.outlined:
        return BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primary,
            width: 1.4,
          ),
        );

      case QuizifyButtonType.glass:
        return BoxDecoration(
          gradient: AppColors.softGlassGradient,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withOpacity(0.25),
          ),
        );
    }
  }

  Color _textColor() {
    switch (type) {
      case QuizifyButtonType.outlined:
        return AppColors.primary;
      case QuizifyButtonType.secondary:
        return AppColors.textPrimary;
      case QuizifyButtonType.primary:
      case QuizifyButtonType.glass:
        return AppColors.textWhite;
    }
  }

  Color _loadingColor() {
    switch (type) {
      case QuizifyButtonType.outlined:
      case QuizifyButtonType.secondary:
        return AppColors.primary;
      case QuizifyButtonType.primary:
      case QuizifyButtonType.glass:
        return AppColors.textWhite;
    }
  }
}