import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/core/utils/app_dialogs.dart';

import '../../../../../../config/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.defultUserImage),
            ),
            shape: BoxShape.circle,
          ),
        ),
        InkWell(
          onTap: () {
            AppDialogs.showCameraDialog(
              context: context,
              onCaremraClicked: () {},
              onGalleryClicked: () {},
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
