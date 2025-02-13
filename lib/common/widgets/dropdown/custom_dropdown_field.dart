import 'package:ai_store/constants/app_colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    this.validatorText,
    this.hintText = '',
    this.dropdownItems = const [],
    this.onChanged,
    this.prefixIcon,
    this.closedHeaderPadding,
    this.expandedHeaderPadding,
    this.errorTextStyle,
    this.borderRadius,
    this.borderColor,
    this.fillColor,
    this.hintStyle,
    this.itemStyle,
    this.textStyle,
    this.suffixIcon,
  });

  final List<String> dropdownItems;
  final String? validatorText;
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final Icon? prefixIcon;
  final EdgeInsets? closedHeaderPadding;
  final EdgeInsets? expandedHeaderPadding;
  final TextStyle? errorTextStyle;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;
  final TextStyle? textStyle;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    late final EdgeInsets effectiveClosedHeaderPadding = closedHeaderPadding ??
        const EdgeInsets.symmetric(vertical: 14, horizontal: 14);
    late final EdgeInsets effectiveExpandedHeaderPadding =
        expandedHeaderPadding ??
            const EdgeInsets.symmetric(vertical: 14, horizontal: 14);
    late final BorderRadius effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(4);
    late final Color effectiveBorderColor =
        borderColor ?? AppColors.groceryBorder;
    late final Color effectiveFillColor = fillColor ?? AppColors.groceryWhite;
    late final Icon effectiveSuffixIconClosed = suffixIcon ??
        const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.grocerySubTitle,
          size: 20,
        );
    late final Icon effectiveSuffixIconExpanded = suffixIcon ??
        const Icon(
          Icons.keyboard_arrow_up_outlined,
          color: AppColors.grocerySubTitle,
          size: 20,
        );

    return CustomDropdown(
      closedHeaderPadding: effectiveClosedHeaderPadding,
      expandedHeaderPadding: effectiveExpandedHeaderPadding,
      validateOnChange: true,
      validator: validatorText == null
          ? null
          : (String? value) => (value == null || value.isEmpty)
              ? "$validatorText is required"
              : null,
      decoration: CustomDropdownDecoration(
        closedErrorBorderRadius: effectiveBorderRadius,
        closedErrorBorder: Border.all(color: AppColors.errorColor),
        errorStyle: errorTextStyle ??
            const TextStyle(
              color: AppColors.errorColor,
              fontSize: 12,
            ),
        closedBorderRadius: effectiveBorderRadius,
        closedBorder: Border.all(color: effectiveBorderColor),
        closedFillColor: effectiveFillColor,
        closedSuffixIcon: effectiveSuffixIconClosed,
        expandedBorderRadius: effectiveBorderRadius,
        expandedBorder: Border.all(color: effectiveBorderColor),
        expandedFillColor: effectiveFillColor,
        expandedSuffixIcon: effectiveSuffixIconExpanded,
        prefixIcon: prefixIcon,
        headerStyle: textStyle ?? const TextStyle(fontSize: 12),
        listItemStyle: itemStyle ?? const TextStyle(fontSize: 12),
        hintStyle: hintStyle ??
            const TextStyle(
              color: AppColors.grocerySubTitle,
              fontSize: 14,
            ),
      ),
      hintText: hintText,
      items: dropdownItems,
      onChanged: onChanged,
    );
  }
}
