import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routing/routes_name.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../view_model/profile_tab/profile_tab_actions.dart';
import '../view_model/profile_tab/profile_tab_states.dart';
import '../view_model/profile_tab/profile_tab_view_model.dart';

class LogoutSection extends StatelessWidget {
  final ProfileTabViewModel viewModel;

  const LogoutSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return BlocListener<ProfileTabViewModel, ProfileTabStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          AppDialogs.showSuccessDialog(
            message: locale.logoutSuccess,
            context: context,
            posActionTitle: locale.ok,
            posAction: () {
              Navigator.pushNamed(context, RoutesName.loginScreen);
            },
          );
        }
      },
      child: InkWell(
        onTap: () {
          viewModel.doIntent(LogOutAction());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.logout,
                    color: ColorsManager.baseBlack,
                    size: 16,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    locale!.logout,
                    style: TextStyles.font14BlackRegular,
                  ),
                ],
              ),
              const Icon(
                Icons.logout,
                color: ColorsManager.baseBlue,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
