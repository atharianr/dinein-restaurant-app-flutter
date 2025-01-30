import 'package:flutter/material.dart';
import 'package:restaurant_app/style/color/dine_in_colors.dart';

import '../../style/typography/dine_in_text_styles.dart';

class DineInTextFieldWidget extends StatelessWidget {
  final Function(String text)? onChanged;
  final String? hint;
  final Icon? prefixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? errorText;

  const DineInTextFieldWidget({
    super.key,
    this.onChanged,
    this.hint,
    this.prefixIcon,
    this.maxLines,
    this.keyboardType,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: DineInTextStyles.bodyLargeMedium.copyWith(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: DineInTextStyles.bodyLargeMedium.copyWith(
          color: Colors.grey,
        ),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: DineInColors.colorPrimary.getColor(context),
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
  }
}
