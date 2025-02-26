import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/text_style.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';
import '../widgets/edit_screen_user_image_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    final UserProfileEntity arguments =
        ModalRoute.of(context)?.settings.arguments as UserProfileEntity;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          locale!.editProfile,
          style: TextStyles.font24BlackMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            UserImageWidget(user: arguments),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
