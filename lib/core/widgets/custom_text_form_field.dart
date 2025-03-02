import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/text_style.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? initialValue;
  final TextEditingController controller;
  final Validator? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    required this.labelText,
    required this.hintText,
    required this.textInputAction,
    required this.keyboardType,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyles.font16DarkGreyMedium,
        hintStyle: TextStyles.font16DarkGreyMedium,
        filled: true,
        fillColor: ColorsManager.lightBlue,
        suffixIcon: suffixIcon,
        suffixIconColor: ColorsManager.secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: ColorsManager.baseBlue,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: ColorsManager.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
