import 'package:flutter/material.dart';

import '../../config/theme/text_style.dart';

class NegativeActionButton extends StatelessWidget {
  final VoidCallback? negativeAction;
  final String negativeActionTitle;

  const NegativeActionButton(
      {required this.negativeActionTitle, this.negativeAction, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          if (negativeAction != null) {
            negativeAction!();
          }
        },
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor:
              WidgetStateProperty.all(Theme.of(context).primaryColor),
          textStyle: WidgetStatePropertyAll(TextStyles.font16WhiteMedium),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: FittedBox(
          child: Text(
            negativeActionTitle,
          ),
        ),
      ),
    );
  }
}
