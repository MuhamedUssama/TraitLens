import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens/config/theme/text_style.dart';

class NotificationsScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationsScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 0,
      title: Text(locale.notification),
      titleTextStyle:
          TextStyles.font20BlackBold.copyWith(fontWeight: FontWeight.w500),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
