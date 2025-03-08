import 'package:flutter/material.dart';

abstract class LanguageStates {}

class LanguageInitialState extends LanguageStates {}

class LanguageChangedState extends LanguageStates {
  final Locale locale;
  LanguageChangedState(this.locale);
}
