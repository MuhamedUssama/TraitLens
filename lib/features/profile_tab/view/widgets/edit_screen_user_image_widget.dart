import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';

class UserImageWidget extends StatelessWidget {
  final UserProfileEntity user;
  const UserImageWidget({super.key, required this.user});

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
          onTap: () {},
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
