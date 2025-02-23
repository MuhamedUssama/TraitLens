import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/core/utils/app_dialogs.dart';

import '../../../../../../config/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';
import '../view_models/fill_profile_actions.dart';
import '../view_models/fill_profile_states.dart';
import '../view_models/fill_profile_view_model.dart';

class UserImageWidget extends StatelessWidget {
  final FillProfileViewModel viewModel;

  const UserImageWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FillProfileViewModel, FillProfileStates>(
      bloc: viewModel,
      buildWhen: (previous, current) => current is ImageSelectedState,
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: viewModel.imageFile != null
                      ? FileImage(viewModel.imageFile!) as ImageProvider
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
      },
    );
  }
}
