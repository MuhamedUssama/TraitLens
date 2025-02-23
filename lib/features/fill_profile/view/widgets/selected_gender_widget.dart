import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../view_models/fill_profile_actions.dart';
import '../view_models/fill_profile_states.dart';
import '../view_models/fill_profile_view_model.dart';
import 'radio_widget.dart';

class SelectedGenderWidget extends StatelessWidget {
  final FillProfileViewModel viewModel;
  const SelectedGenderWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return BlocBuilder<FillProfileViewModel, FillProfileStates>(
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
              child: RadioWidget(
                value: Gender.female,
                groupValue: viewModel.selectedGender,
                onChangeGender: (gender) {
                  viewModel.doIntent(ChangeGenderAction(gender));
                },
                title: locale.female,
              ),
            ),
            Expanded(
              child: RadioWidget(
                value: Gender.male,
                groupValue: viewModel.selectedGender,
                onChangeGender: (value) {
                  viewModel.doIntent(ChangeGenderAction(value));
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
