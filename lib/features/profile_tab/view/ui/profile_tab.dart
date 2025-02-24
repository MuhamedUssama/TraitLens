import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/di/di.dart';
import '../view_model/profile_tab_actions.dart';
import '../view_model/profile_tab_view_model.dart';
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
        UserDataWidget(viewModel: viewModel),
        SizedBox(height: 75.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            children: [
              const EditProfileWidget(),
              SizedBox(height: 8.h),
              const Divider(color: ColorsManager.grey),
              SizedBox(height: 8.h),
              NotificationsWidget(viewModel: viewModel),
              SizedBox(height: 8.h),
              const Divider(color: ColorsManager.grey),
              const LanguageSectionWidget(),
              CustomBasicSection(title: locale!.aboutUs),
              CustomBasicSection(title: locale.termsAndConditions),
              const Divider(color: ColorsManager.grey),
              const LogoutSection(),
              SizedBox(height: 80.h),
              Text('v 6.3.0 - (446)', style: TextStyles.font12GreyBold),
            ],
          ),
        )
      ],
    );
  }
}
