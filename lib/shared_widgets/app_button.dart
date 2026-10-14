import 'package:flutter/material.dart';
import 'colors.dart';
import 'app_text_style.dart';

class AppButton extends StatelessWidget {
  final Color backgroundColor;
  final double width;
  final double height;
  final String text;
  final Color textColor;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    this.backgroundColor = AppColors.primaryColor, 
    this.width = 354,                  
    this.height = 40,                             
    required this.text,
    this.textColor = AppColors.white,             
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0, 
          disabledBackgroundColor: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyle.s16_w600(color: textColor),
        ),
      ),
    );
  }
}
