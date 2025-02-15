import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens/config/theme/app_colors.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../view_models/sign_up_view_model/sign_up_actions.dart';
import '../view_models/sign_up_view_model/sign_up_view_model.dart';

class SignUpForm extends StatelessWidget {
  final SignUpViewModel viewModel;
  const SignUpForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      onChanged: () => viewModel.doIntent(FormDataChangedAction()),
      child: Column(
        children: [
          CustomTextFormField(
            controller: viewModel.emailController,
            labelText: AppLocalizations.of(context)!.email,
            hintText: AppLocalizations.of(context)!.enterYourEmail,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: (email) => AppValidator.validateEmailAddress(
              context: context,
              email: email,
            ),
          ),
          SizedBox(height: 26.h),
          ValueListenableBuilder(
            valueListenable: viewModel.passwordVisible,
            builder: (context, value, child) => CustomTextFormField(
              controller: viewModel.passwordController,
              labelText: AppLocalizations.of(context)!.password,
              hintText: AppLocalizations.of(context)!.enterYourPassword,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              obscureText: value,
              suffixIcon: InkWell(
                onTap: () {
                  viewModel.doIntent(ChangePasswordVisibilityAction());
                },
                child: Icon(value ? Icons.visibility_off : Icons.visibility),
              ),
              validator: (email) => AppValidator.validateFieldIsNotEmpty(
                value: viewModel.passwordController.text,
                message: AppLocalizations.of(context)!.emptyPassword,
              ),
            ),
          ),
          SizedBox(height: 26.h),
          ValueListenableBuilder(
            valueListenable: viewModel.passwordConfirmationVisible,
            builder: (context, value, child) => CustomTextFormField(
              controller: viewModel.confirmPasswordController,
              labelText: AppLocalizations.of(context)!.confirmPassword,
              hintText: AppLocalizations.of(context)!.enterYourConfirmPassword,
              obscureText: value,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              suffixIcon: InkWell(
                onTap: () {
                  viewModel
                      .doIntent(ChangePasswordConfirmationVisibilityAction());
                },
                child: Icon(value ? Icons.visibility_off : Icons.visibility),
              ),
              validator: (email) => AppValidator.validateConfirmPassword(
                context: context,
                password: viewModel.passwordController.text,
                confirmPassword: viewModel.confirmPasswordController.text,
              ),
            ),
          ),
          SizedBox(height: 52.h),
          ElevatedButton(
            onPressed: () {
              viewModel.doIntent(SignUpWithEmailAndPasswordAction());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 60.h),
              backgroundColor: ColorsManager.baseBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.signUp,
              style: TextStyles.font20WhiteSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
