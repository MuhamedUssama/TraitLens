import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:trait_lens/features/ai_detection/view/widgets/detection_app_bar.dart';

class ResultDetailsScreen extends StatelessWidget {
  const ResultDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.results),
    );
  }
}
