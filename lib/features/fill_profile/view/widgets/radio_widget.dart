import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../view_models/fill_profile_view_model.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChangeGender,
  });

  final Gender value;
  final Gender groupValue;
  final String title;
  final Function(Gender gender) onChangeGender;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        onChangeGender.call(value);
      },
      child: Row(
        children: [
          Radio<Gender>(
            activeColor: ColorsManager.baseBlue,
            value: value,
            groupValue: groupValue,
            onChanged: (Gender? value) {
              onChangeGender.call(value!);
            },
          ),
          Text(title, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
