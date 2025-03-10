import 'package:flutter/material.dart';

import '../../../../config/theme/text_style.dart';

class DetectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DetectionAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.font20BlackBold,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
