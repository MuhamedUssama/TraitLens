import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens/config/routing/routes_name.dart';
import 'package:trait_lens/core/di/di.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../view_models/sign_in_view_model/sign_in_actions.dart';
import '../view_models/sign_in_view_model/sign_in_states.dart';
import '../view_models/sign_in_view_model/sign_in_view_model.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInViewModel viewModel = getIt.get<SignInViewModel>();

  @override
  void dispose() {
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
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
                  height: 26.h,
                  title: AppLocalizations.of(context)!.loginHere,
                  message: AppLocalizations.of(context)!.loginMessage,
                  titleTextStyle: TextStyles.font30BlueBold,
                  messageTextStyle: TextStyles.font20GreyBold,
                ),
                SizedBox(height: 74.h),
                BlocListener<SignInViewModel, SignInStates>(
                    bloc: viewModel,
                    listener: (context, state) {
                      if (state is SignInLoadingState) {
                        AppDialogs.showLoading(
                          message: AppLocalizations.of(context)!.loading,
                          context: context,
                        );
                      }
                      if (state is HideLoadingState) {
                        AppDialogs.hideLoading(context);
                      }
                      if (state is SignInErrorState) {
                        AppDialogs.showFailDialog(
                          message: state.errorMessage,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                        );
                      }
                      if (state is NavigateToSignUpScreenState) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.signUpScreen,
                        );
                      }
                      if (state is NavigateToForgetPasswordScreenState) {
                        Navigator.pushNamed(
                          context,
                          RoutesName.forgetPasswordScreen,
                          arguments: viewModel.emailController.text,
                        );
                      }
                      if (state is NavigateToHomeScreenState) {
                        Navigator.pushNamed(context, RoutesName.homeScreen);
                      }
                      if (state is SignInSuccessState) {
                        AppDialogs.showSuccessDialog(
                          message: AppLocalizations.of(context)!
                              .loggedInSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel.doIntent(NavigateToHomeScreenAction());
                          },
                        );
                      }
                      if (state is SignInWithGoogleState) {
                        AppDialogs.showSuccessDialog(
                          message: AppLocalizations.of(context)!
                              .loggedInSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel.doIntent(NavigateToHomeScreenAction());
                          },
                        );
                      }
                      if (state is SignInWithFacebookState) {
                        AppDialogs.showSuccessDialog(
                          message: AppLocalizations.of(context)!
                              .loggedInSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel.doIntent(NavigateToHomeScreenAction());
                          },
                        );
                      }
                    },
                    child: SignInForm(viewModel: viewModel)),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
