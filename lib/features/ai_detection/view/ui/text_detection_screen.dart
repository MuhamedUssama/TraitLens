import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/detection_app_bar.dart';
import '../widgets/detection_header_section.dart';

class TextDetectionScreen extends StatelessWidget {
  const TextDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.textScreen),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          children: [
            DetectionHeaderSection(title: locale.textScreenBody),
            SizedBox(height: 34.h),
          ],
        ),
      ),
    );
  }
}
