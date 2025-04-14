import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens/config/theme/app_colors.dart';
import 'package:trait_lens/core/utils/app_assets.dart';
import 'package:trait_lens/core/utils/app_dialogs.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/image_view_model/image_detection_states.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/image_view_model/image_detection_view_model.dart';

class TakeImageFromUserWidget extends StatelessWidget {
  final ImageDetectionViewModel viewModel;

  const TakeImageFromUserWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageDetectionViewModel, ImageDetectionStates>(
      bloc: viewModel,
      buildWhen: (previous, current) => current is ImageSelectedState,
      builder: (context, state) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 120.r,
            backgroundColor: ColorsManager.white,
            backgroundImage: viewModel.imageFile != null
                ? FileImage(viewModel.imageFile!) as ImageProvider
                : const AssetImage(AppAssets.defultUserImage),
          ),
          InkWell(
            onTap: () {
              AppDialogs.showCameraDialog(
                context: context,
                onCaremraClicked: () {
                  viewModel.clickOnCameraButton();
                  Navigator.pop(context);
                },
                onGalleryClicked: () {
                  viewModel.clickOnGalleryButton();
                  Navigator.pop(context);
                },
              );
            },
            child: Container(
              width: 45.w,
              height: 45.w,
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
      ),
    );
  }
}
