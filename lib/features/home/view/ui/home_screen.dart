import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/theme/text_style.dart';
import '../widgets/notification_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale!.traitLengs, style: TextStyles.font32BlueBold),
        actions: const [
          NotificationWidget(),
        ],
      ),
    );
  }
}
