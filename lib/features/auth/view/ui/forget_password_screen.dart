import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/routing/routes_name.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../view_models/forget_password_view_model/forget_password_actions.dart';
import '../view_models/forget_password_view_model/forget_password_states.dart';
import '../view_models/forget_password_view_model/forget_password_view_model.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/forget_password_form.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ForgetPasswordViewModel viewModel = getIt.get<ForgetPasswordViewModel>();

  @override
  void dispose() {
    viewModel.emailController.dispose();
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
                    title: AppLocalizations.of(context)!.forgotPassword,
                    message:
                        AppLocalizations.of(context)!.forgetPasswordMessage,
                    titleTextStyle: TextStyles.font30BlueBold,
                    messageTextStyle: TextStyles.font14GreySemiBold,
                  ),
                  SizedBox(height: 74.h),
                  BlocListener<ForgetPasswordViewModel, ForgetPasswordStates>(
                    bloc: viewModel,
                    listener: (context, state) {
                      if (state is ForgetPasswordLoadingState) {
                        AppDialogs.showLoading(
                          message: AppLocalizations.of(context)!.loading,
                          context: context,
                        );
                      }
                      if (state is ForgetPasswordHideLoadingState) {
                        AppDialogs.hideLoading(context);
                      }
                      if (state is NavigateToLoginScreenState) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.forgetPasswordScreen,
                        );
                      }
                      if (state is ForgetPasswordSuccessState) {
                        AppDialogs.showSuccessDialog(
                          message: AppLocalizations.of(context)!
                              .forgetPasswordLinkSentSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel.doIntent(NavigateToLoginScreenAction());
                          },
                        );
                      }
                      if (state is ForgetPasswordErrorState) {
                        AppDialogs.showFailDialog(
                          message: state.message,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                        );
                      }
                    },
                    child: ForgetPasswordForm(viewModel: viewModel),
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
