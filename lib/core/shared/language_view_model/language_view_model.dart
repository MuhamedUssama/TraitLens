import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../cache/shared_preferences.dart';
import 'language_states.dart';

@injectable
class LanguageViewModel extends Cubit<LanguageStates> {
  LanguageViewModel() : super(LanguageInitialState()) {
    _loadSavedLanguage();
  }

  static const String _languageKey = 'language';

  void _loadSavedLanguage() {
    String savedLanguage = SharedPreferencesHelper.getString(key: _languageKey);
    String initialLocale = savedLanguage.isNotEmpty ? savedLanguage : 'en';
    emit(LanguageChangedState(Locale(initialLocale)));
  }

  void changeLanguage(String languageCode) {
    final newLocale = Locale(languageCode);
    SharedPreferencesHelper.saveData(key: _languageKey, value: languageCode);
    emit(LanguageChangedState(newLocale));
  }
}
