import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/shared/language_view_model/language_view_model.dart';

class LanguageSectionWidget extends StatelessWidget {
  const LanguageSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    LanguageViewModel languageViewModel = context.read<LanguageViewModel>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.translate,
                color: ColorsManager.baseBlack,
              ),
              SizedBox(width: 4.w),
              Text(
                locale!.language,
                style: TextStyles.font14BlackRegular,
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              String newLanguage = locale.localeName == 'en' ? 'ar' : 'en';
              languageViewModel.changeLanguage(newLanguage);
            },
            child: Text(
              locale.languageKeyword,
              style: TextStyles.font12BlueRegular,
            ),
          ),
        ],
      ),
    );
  }
}
