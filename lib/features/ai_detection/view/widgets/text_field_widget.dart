import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/validation_utils.dart';
import '../view_models/text_view_model/text_detection_view_model.dart';

class CustomTextField extends StatefulWidget {
  final TextDetectionViewModel viewModel;

  const CustomTextField({super.key, required this.viewModel});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Form(
      key: widget.viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 270.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[100]!.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: widget.viewModel.textController,
              maxLines: null,
              cursorColor: Colors.grey[600],
              cursorRadius: Radius.circular(10.r),
              style: TextStyles.textMessageTextScreen
                  .copyWith(fontWeight: FontWeight.w500),
              validator: (value) {
                final validation = AppValidator.validateFieldIsNotEmpty(
                  value: value,
                  message: locale.emptyField,
                );
                setState(() {
                  errorMessage = validation;
                });
                return null;
              },
              decoration: InputDecoration(
                hintText: locale!.typeHere,
                hintStyle: TextStyles.textMessageTextScreen,
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16.h),
              ),
            ),
          ),
          if (errorMessage != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h, left: 16.w),
              child: Text(
                errorMessage!,
                style: TextStyle(
                  color: ColorsManager.red,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
