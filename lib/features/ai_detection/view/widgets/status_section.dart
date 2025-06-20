import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../data/models/traits_model.dart';
import 'status_item_widget.dart';

class StatusSection extends StatelessWidget {
  final Traits? traits;
  const StatusSection({super.key, this.traits});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(locale!.status, style: TextStyles.statusText),
            Text('%', style: TextStyles.statusText),
          ],
        ),
        const Divider(),
        FadeInLeft(
          delay: const Duration(milliseconds: 100),
          child: StatusItemWidget(
            color: ColorsManager.openness,
            title: locale.openness,
            percentage: traits?.opennessO ?? '0%',
          ),
        ),
        FadeInLeft(
          delay: const Duration(milliseconds: 200),
          child: StatusItemWidget(
            color: ColorsManager.conscientiousness,
            title: locale.conscientiousness,
            percentage: traits?.conscientiousnessC ?? '0%',
          ),
        ),
        FadeInLeft(
          delay: const Duration(milliseconds: 300),
          child: StatusItemWidget(
            color: ColorsManager.extraversion,
            title: locale.extraversion,
            percentage: traits?.extraversionE ?? '0%',
          ),
        ),
        FadeInLeft(
          delay: const Duration(milliseconds: 400),
          child: StatusItemWidget(
            color: ColorsManager.agreeableness,
            title: locale.agreeableness,
            percentage: traits?.agreeablenessA ?? '0%',
          ),
        ),
        FadeInLeft(
          delay: const Duration(milliseconds: 500),
          child: StatusItemWidget(
            color: ColorsManager.neuroticism,
            title: locale.neuroticism,
            percentage: traits?.neuroticismN ?? '0%',
          ),
        ),
      ],
    );
  }
}
