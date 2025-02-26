import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/routing/routes_name.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/app_assets.dart';
import '../view_model/profile_tab_actions.dart';
import '../view_model/profile_tab_states.dart';
import '../view_model/profile_tab_view_model.dart';

class EditProfileWidget extends StatelessWidget {
  final ProfileTabViewModel viewModel;

  const EditProfileWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return BlocListener<ProfileTabViewModel, ProfileTabStates>(
      bloc: viewModel,
      listenWhen: (previous, current) =>
          current is NavigateToEditProfileScreenState,
      listener: (context, state) {
        if (state is NavigateToEditProfileScreenState) {
          Navigator.pushNamed(context, RoutesName.editProfileScreen);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: InkWell(
          onTap: () {
            viewModel.doIntent(NavigateToEditProfileScreenAction());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppSvg.pen),
                  SizedBox(width: 4.w),
                  Text(
                    locale!.editProfile,
                    style: TextStyles.font14BlackRegular,
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: ColorsManager.darkGrey,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
