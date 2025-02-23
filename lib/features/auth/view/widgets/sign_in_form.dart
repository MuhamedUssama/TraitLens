import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../view_models/sign_in_view_model/sign_in_actions.dart';
import '../view_models/sign_in_view_model/sign_in_states.dart';
import '../view_models/sign_in_view_model/sign_in_view_model.dart';

class SignInForm extends StatelessWidget {
  final SignInViewModel viewModel;

  const SignInForm({super.key, required this.viewModel});

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
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: (email) => AppValidator.validateEmailAddress(
              context: context,
              email: email,
            ),
          ),
          SizedBox(height: 30.h),
          ValueListenableBuilder(
            valueListenable: viewModel.passwordVisible,
            builder: (context, value, child) => CustomTextFormField(
              controller: viewModel.passwordController,
              labelText: AppLocalizations.of(context)!.password,
              hintText: AppLocalizations.of(context)!.enterYourPassword,
              textInputAction: TextInputAction.done,
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
          SizedBox(height: 30.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                viewModel.doIntent(NavigateToForgetPasswordScreenAction());
              },
              child: Text(
                AppLocalizations.of(context)!.forgotYourPassword,
                style: TextStyles.font14BlueSemiBold,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed: () {
              viewModel.doIntent(SignInWithEmailAndPasswordAction());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 60.h),
              backgroundColor: ColorsManager.baseBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: BlocBuilder<SignInViewModel, SignInStates>(
              bloc: viewModel,
              buildWhen: (previous, current) => current is SignInLoadingState,
              builder: (context, state) {
                return state is SignInLoadingState
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.signIn,
                        style: TextStyles.font20WhiteSemiBold,
                      );
              },
            ),
          ),
          SizedBox(height: 30.h),
          TextButton(
            onPressed: () {
              viewModel.doIntent(NavigateToSignUpScreenAction());
            },
            child: Text(
              AppLocalizations.of(context)!.createNewAccount,
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
                  viewModel.doIntent(SignInWithGoogleAction());
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
                  viewModel.doIntent(SignInWithFacebookAction());
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
