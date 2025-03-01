import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_states.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_view_model.dart';
import '../widgets/edit_screen_form_data.dart';
import '../widgets/edit_screen_user_image_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileScreenViewModel viewModel =
      getIt.get<EditProfileScreenViewModel>();
  UserProfileEntity? arguments;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized && ModalRoute.of(context)?.settings.arguments != null) {
      arguments =
          ModalRoute.of(context)!.settings.arguments as UserProfileEntity;
      viewModel.birthdayController.text = arguments!.birthDay ?? '';
      viewModel.nameController.text = arguments!.fullName ?? '';
      viewModel.phoneController.text = arguments!.phone ?? '';
      viewModel.selectedGender = arguments!.gender?.toLowerCase() == "male"
          ? Gender.male
          : Gender.female;
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    viewModel.birthdayController.dispose();
    viewModel.nameController.dispose();
    viewModel.phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(AppAssets.background)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: BlocListener<EditProfileScreenViewModel,
                EditProfileScreenStates>(
              bloc: viewModel,
              listener: (context, state) {
                if (state is EditProfileFailureState) {
                  AppDialogs.showFailDialog(
                    message: state.message ?? locale.somethingWentWrong,
                    context: context,
                    posActionTitle: locale.ok,
                  );
                }
                if (state is EditProfileSuccessState) {
                  AppDialogs.showSuccessDialog(
                    message: locale.fillProfileSuccessfully,
                    context: context,
                    posActionTitle: locale.ok,
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  UserImageWidget(
                    user: arguments!,
                    viewModel: viewModel,
                  ),
                  SizedBox(height: 50.h),
                  EditScreenFormData(viewModel: viewModel, user: arguments!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
