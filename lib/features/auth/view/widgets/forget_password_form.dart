import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../view_models/forget_password_view_model/forget_password_actions.dart';
import '../view_models/forget_password_view_model/forget_password_view_model.dart';

class ForgetPasswordForm extends StatelessWidget {
  final ForgetPasswordViewModel viewModel;

  const ForgetPasswordForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: viewModel.emailController,
            labelText: AppLocalizations.of(context)!.email,
            hintText: AppLocalizations.of(context)!.enterYourEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: (email) => AppValidator.validateEmailAddress(
              context: context,
              email: email,
            ),
          ),
          SizedBox(height: 50.h),
          ElevatedButton(
            onPressed: () {
              viewModel.doIntent(ForgetPasswordSubmitAction());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 60.h),
              backgroundColor: ColorsManager.baseBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.submit,
              style: TextStyles.font20WhiteSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
