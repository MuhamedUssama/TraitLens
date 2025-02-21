import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens/config/routing/routes_name.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../auth/view/widgets/auth_header_widget.dart';
import '../view_models/fill_profile_actions.dart';
import '../view_models/fill_profile_states.dart';
import '../view_models/fill_profile_view_model.dart';
import '../widgets/fill_profile_form_widget.dart';
import '../widgets/user_image_widget.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  FillProfileViewModel viewModel = getIt.get<FillProfileViewModel>();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                AuthHeaderWidget(
                  height: 6.h,
                  title: AppLocalizations.of(context)!.fillYourProfile,
                  titleTextStyle: TextStyles.font30BlueBold,
                  message: AppLocalizations.of(context)!.fillProfileMessage,
                  messageTextStyle: TextStyles.font14GreyRegular,
                ),
                SizedBox(height: 28.h),
                const UserImageWidget(),
                SizedBox(height: 47.h),
                BlocListener<FillProfileViewModel, FillProfileStates>(
                  bloc: viewModel,
                  listener: (context, state) {
                    if (state is FillProfileLoadingState) {
                      AppDialogs.showLoading(
                        message: AppLocalizations.of(context)!.loading,
                        context: context,
                      );
                    }
                    if (state is FillProfileHideLoadingState) {
                      AppDialogs.hideLoading(context);
                    }
                    if (state is FillProfileErrorState) {
                      AppDialogs.showFailDialog(
                        message: state.message ??
                            AppLocalizations.of(context)!.somethingWentWrong,
                        context: context,
                        posActionTitle: AppLocalizations.of(context)!.ok,
                      );
                    }
                    if (state is FillProfileSuccessState) {
                      AppDialogs.showSuccessDialog(
                        message: AppLocalizations.of(context)!
                            .fillProfileSuccessfully,
                        context: context,
                        posActionTitle: AppLocalizations.of(context)!.ok,
                        posAction: () {
                          viewModel.doIntent(NavigateToHomeScreenAction());
                        },
                      );
                    }
                    if (state is NavigateToHomeScreenState) {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesName.homeScreen,
                      );
                    }
                  },
                  child: FillProfileFormWidget(viewModel: viewModel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
