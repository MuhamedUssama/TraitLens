import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../view_model/edit_profile_screen/edit_profile_screen_actions.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_states.dart';
import '../view_model/edit_profile_screen/edit_profile_screen_view_model.dart';
import 'edit_screen_radio_widget.dart';

class EditScreenSelectedGender extends StatelessWidget {
  final EditProfileScreenViewModel viewModel;
  const EditScreenSelectedGender({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return BlocBuilder<EditProfileScreenViewModel, EditProfileScreenStates>(
      bloc: viewModel,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              locale!.gender,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 18),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: EditScreenRadioWidget(
                value: Gender.female,
                groupValue: viewModel.selectedGender,
                onChangeGender: (gender) {
                  viewModel.doIntent(ChangGenderAction(gender));
                },
                title: locale.female,
              ),
            ),
            Expanded(
              child: EditScreenRadioWidget(
                value: Gender.male,
                groupValue: viewModel.selectedGender,
                onChangeGender: (value) {
                  viewModel.doIntent(ChangGenderAction(value));
                },
                title: locale.male,
              ),
            ),
          ],
        );
      },
    );
  }
}
