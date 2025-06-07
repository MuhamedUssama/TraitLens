import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/di/di.dart';
import '../view_model/profile_tab/profile_tab_actions.dart';
import '../view_model/profile_tab/profile_tab_view_model.dart';
import '../widgets/custom_basic_section.dart';
import '../widgets/edit_profile_widget.dart';
import '../widgets/language_section_widget.dart';
import '../widgets/logout_section.dart';
import '../widgets/notifications_widget.dart';
import '../widgets/user_data_widget.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late final ProfileTabViewModel viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ProfileTabViewModel>();
    viewModel.doIntent(GetUserProfileDataAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Column(
      children: [
        SizedBox(height: 28.h),
        FadeInDown(child: UserDataWidget(viewModel: viewModel)),
        SizedBox(height: 75.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            children: [
              FadeInLeft(
                delay: const Duration(milliseconds: 100),
                child: EditProfileWidget(viewModel: viewModel),
              ),
              SizedBox(height: 8.h),
              FadeInLeft(
                delay: const Duration(milliseconds: 200),
                child: const Divider(color: ColorsManager.grey),
              ),
              SizedBox(height: 8.h),
              FadeInLeft(
                delay: const Duration(milliseconds: 300),
                child: NotificationsWidget(),
              ),
              SizedBox(height: 8.h),
              FadeInLeft(
                delay: const Duration(milliseconds: 400),
                child: const Divider(color: ColorsManager.grey),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 500),
                child: const LanguageSectionWidget(),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 600),
                child: CustomBasicSection(title: locale!.aboutUs),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 700),
                child: CustomBasicSection(title: locale.termsAndConditions),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 800),
                child: const Divider(color: ColorsManager.grey),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 900),
                child: LogoutSection(viewModel: viewModel),
              ),
              SizedBox(height: 80.h),
              Text('v 1.0.0', style: TextStyles.font12GreyBold),
            ],
          ),
        )
      ],
    );
  }
}
