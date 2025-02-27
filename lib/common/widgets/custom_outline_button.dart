import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonBorder extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final double fontSizeValue;

  const CustomButtonBorder({
    super.key,
    required this.title,
    required this.onPressed,
    this.textStyle,
    this.fontSizeValue = 12,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    EdgeInsetsGeometry buttonPadding = screenWidth < 360
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 4)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 6);

    double fontSize = screenWidth < 360 ? 10 : fontSizeValue;

    TextStyle effectiveTextStyle = textStyle ??
        TextStyle(
          color: AppColors.groceryPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        );

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: WidgetStateProperty.all(
          BorderSide(
              color: AppColors.groceryPrimary,
              width: screenWidth < 360 ? 1.0 : 1.5),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        padding: WidgetStateProperty.all(buttonPadding),
      ),
      child: Text(
        title,
        style: effectiveTextStyle,
      ),
    );
  }
}
