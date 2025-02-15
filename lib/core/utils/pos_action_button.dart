import 'package:flutter/material.dart';
import 'package:trait_lens/config/theme/app_colors.dart';

import '../../config/theme/text_style.dart';

class PosActionButton extends StatelessWidget {
  final VoidCallback? posAction;
  final String posActionTitle;

  const PosActionButton(
      {required this.posActionTitle, this.posAction, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          if (posAction != null) {
            posAction!();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.baseBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FittedBox(
            child: Text(
              posActionTitle,
              style: TextStyles.font16WhiteMedium,
            ),
          ),
        ),
      ),
    );
  }
}
