import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/core/utils/app_assets.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../view_models/sign_up_view_model/sign_up_actions.dart';
import '../view_models/sign_up_view_model/sign_up_states.dart';
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
          BlocBuilder<SignUpViewModel, SignUpStates>(
            bloc: viewModel,
            buildWhen: (previous, current) => current is SignUpLoadingState,
            builder: (context, state) {
              return ElevatedButton(
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
                child: state is SignUpLoadingState
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.signUp,
                        style: TextStyles.font20WhiteSemiBold,
                      ),
              );
            },
          ),
          SizedBox(height: 30.h),
          TextButton(
            onPressed: () => viewModel.doIntent(NavigateToSignInScreenAction()),
            child: Text(
              AppLocalizations.of(context)!.alreadyHaveAnAccount,
              style: TextStyles.font14GreySemiBold,
            ),
          ),
          SizedBox(height: 65.h),
          Text(
            AppLocalizations.of(context)!.orContinueWith,
            style: TextStyles.font14BlueSemiBold,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  viewModel.doIntent(SignUpWithGoogleAction());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                minWidth: 60.w,
                height: 44.h,
                color: ColorsManager.lightGrey,
                child: Image.asset(
                  AppAssets.googleLogo,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              MaterialButton(
                onPressed: () {
                  viewModel.doIntent(SignUpWithFacebookAction());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                minWidth: 60.w,
                height: 44.h,
                color: ColorsManager.lightGrey,
                child: Icon(Icons.facebook, color: Colors.black, size: 24.w),
              ),
            ],
          )
        ],
      ),
    );
  }
}
