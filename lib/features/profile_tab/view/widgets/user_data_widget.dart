import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../view_model/profile_tab_states.dart';
import '../view_model/profile_tab_view_model.dart';

class UserDataWidget extends StatelessWidget {
  final ProfileTabViewModel viewModel;

  const UserDataWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileTabViewModel, ProfileTabStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is GetUserDataSuccessState) {
          return Center(
            child: Column(
              children: [
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: state.user!.profileImageUrl ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Skeletonizer(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  state.user?.fullName ?? "",
                  style: TextStyles.font18BlackMedium,
                ),
                SizedBox(height: 4.h),
                Text(
                  viewModel.email ?? "",
                  style: TextStyles.font18BlackMedium.copyWith(
                    color: ColorsManager.darkGrey,
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProfileTabLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetUserDataErrorState) {
          return Center(child: Text(state.errorMessage ?? ""));
        } else {
          return Container(color: Colors.red, width: 10.w, height: 20.h);
        }
      },
    );
  }
}
