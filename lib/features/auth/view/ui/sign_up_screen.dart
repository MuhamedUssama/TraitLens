import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/core/di/di.dart';
import 'package:trait_lens/features/auth/view/view_models/sign_up_view_model/sign_up_actions.dart';

import '../../../../config/routing/routes_name.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../view_models/sign_up_view_model/sign_up_states.dart';
import '../view_models/sign_up_view_model/sign_up_view_model.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpViewModel viewModel = getIt.get<SignUpViewModel>();

  @override
  void dispose() {
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
    viewModel.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 60.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthHeaderWidget(
                    height: 6.h,
                    title: AppLocalizations.of(context)!.createAccount,
                    message: AppLocalizations.of(context)!.signUpMessage,
                    titleTextStyle: TextStyles.font30BlueBold,
                    messageTextStyle: TextStyles.font12GreyBold,
                  ),
                  SizedBox(height: 28.h),
                  BlocListener<SignUpViewModel, SignUpStates>(
                    bloc: viewModel,
                    listener: (context, state) {
                      // if (state is SignUpLoadingState) {
                      //   AppDialogs.showLoading(
                      //     message: AppLocalizations.of(context)!.loading,
                      //     context: context,
                      //   );
                      // }
                      // if (state is HideLoadingState) {
                      //   Navigator.pop(context);
                      // }
                      if (state is VerifyAccountState) {
                        AppDialogs.showSuccessDialog(
                          message: state.message,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel
                                .doIntent(NavigateToFillProfileScreenAction());
                          },
                        );
                      }
                      if (state is SignUpSuccessState) {
                        AppDialogs.showSuccessDialog(
                          message: AppLocalizations.of(context)!
                              .accountCreatedSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel.doIntent(VerifyAccountAction());
                          },
                        );
                      }
                      if (state is SignUpWithGoogleSuccessState) {
                        AppDialogs.showSuccessDialog(
                          message: AppLocalizations.of(context)!
                              .accountCreatedSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel
                                .doIntent(NavigateToFillProfileScreenAction());
                          },
                        );
                      }
                      if (state is SignUpWithFacebookSuccessState) {
                        AppDialogs.showSuccessDialog(
                          message: AppLocalizations.of(context)!
                              .accountCreatedSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel
                                .doIntent(NavigateToFillProfileScreenAction());
                          },
                        );
                      }
                      if (state is SignUpErrorState) {
                        AppDialogs.showFailDialog(
                          message: state.message,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                        );
                      }
                      if (state is NavigateToSignInScreenState) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.loginScreen,
                        );
                      }
                      if (state is NavigateToFillProfileScreenState) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.fillProfileScreen,
                        );
                      }
                    },
                    child: SignUpForm(viewModel: viewModel),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
