import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trait_lens/core/utils/app_dialogs.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_states.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_view_model.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_actions.dart';
import 'edit_screen_selected_gender.dart';

class EditScreenFormData extends StatelessWidget {
  final EditProfileScreenViewModel viewModel;
  final UserProfileEntity user;

  const EditScreenFormData({
    super.key,
    required this.viewModel,
    required this.user,
  });

  void _openDatePicker(BuildContext context) {
    AppDialogs.takeUserBirthday(
      context: context,
      controller: viewModel.birthdayController,
      onPicked: (timestamp) {
        viewModel.doIntent(UpdateBirthdayAction(timestamp));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    return Column(
      children: [
        Column(
          children: [
            Form(
              key: viewModel.formKey,
              onChanged: () => viewModel.doIntent(FormDataChangedAction()),
              child: Column(
                children: [
                  FadeInLeft(
                    delay: const Duration(milliseconds: 300),
                    child: CustomTextFormField(
                      controller: viewModel.nameController,
                      labelText: locale!.fullName,
                      hintText: locale.fullName,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: (name) => AppValidator.validateFieldIsNotEmpty(
                        value: name,
                        message: locale.emptyName,
                      ),
                    ),
                  ),
                  SizedBox(height: 26.h),
                  FadeInRight(
                    delay: const Duration(milliseconds: 300),
                    child: CustomTextFormField(
                      controller: viewModel.birthdayController,
                      labelText: locale.birthday,
                      hintText: locale.birthday,
                      readOnly: true,
                      onTap: () => _openDatePicker(context),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.none,
                      validator: (birthDay) =>
                          AppValidator.validateFieldIsNotEmpty(
                        value: birthDay,
                        message: locale.emptyBirthDay,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _openDatePicker(context),
                      ),
                    ),
                  ),
                  SizedBox(height: 26.h),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 300),
                    child: CustomTextFormField(
                      controller: viewModel.phoneController,
                      labelText: locale.phoneNumber,
                      hintText: locale.phoneNumber,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      validator: (phone) =>
                          AppValidator.validateFieldIsNotEmpty(
                        value: phone,
                        message: locale.emptyPhoneNumber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            FadeInRight(
              delay: const Duration(milliseconds: 300),
              child: EditScreenSelectedGender(viewModel: viewModel),
            ),
            SizedBox(height: 66.h),
            BlocBuilder<EditProfileScreenViewModel, EditProfileScreenStates>(
              bloc: viewModel,
              buildWhen: (previous, current) =>
                  current is EditProfileLoadingState ||
                  current is EditProfileSuccessState ||
                  current is EditProfileFailureState,
              builder: (context, state) {
                return FadeInLeft(
                  delay: const Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.doIntent(UpdateUserDataAction());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60.h),
                      backgroundColor: ColorsManager.baseBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: state is EditProfileLoadingState
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 40,
                            ),
                          )
                        : Text(
                            locale.update,
                            style: TextStyles.font20WhiteSemiBold,
                          ),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
