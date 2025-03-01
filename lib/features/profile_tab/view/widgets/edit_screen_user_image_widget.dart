import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_actions.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_view_model.dart';

class UserImageWidget extends StatelessWidget {
  final UserProfileEntity user;
  final EditProfileScreenViewModel viewModel;
  const UserImageWidget(
      {super.key, required this.user, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: user.profileImageUrl != null
                  ? NetworkImage(user.profileImageUrl!)
                  : const AssetImage(AppAssets.defultUserImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            AppDialogs.showCameraDialog(
              context: context,
              onCaremraClicked: () {
                viewModel.doIntent(CameraClickedAction());
                Navigator.pop(context);
              },
              onGalleryClicked: () {
                viewModel.doIntent(GalleryClickedAction());
                Navigator.pop(context);
              },
            );
          },
          child: Container(
            width: 30.w,
            height: 30.w,
            decoration: const BoxDecoration(
              color: ColorsManager.darkWhite,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: ColorsManager.baseBlue,
            ),
          ),
        ),
      ],
    );
  }
}
