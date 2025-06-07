import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

import '../../../domain/usecases/send_text_usecase.dart';
import 'text_detection_actions.dart';
import 'text_detection_states.dart';

@injectable
class TextDetectionViewModel extends Cubit<TextDetectionStates> {
  final SendTextUsecase _textUsecase;

  @factoryMethod
  TextDetectionViewModel(this._textUsecase)
      : super(TextDetectionInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  Future<void> doIntent(TextDetectionActions actions) async {
    switch (actions) {
      case SubmitClickAction():
        _sendTextMessage();
      case NavigateToAudioScreenAction():
        _navigateToAudioScreen();
    }
  }

  Future<void> _sendTextMessage() async {
    log(langdetect.detect(textController.text));
    if (formKey.currentState!.validate()) {
      if (langdetect.detect(textController.text) == "en") {
        emit(TextDetectionLoadingState());

        final result = await _textUsecase.call(text: textController.text);

        result.fold(
          (failure) => emit(TextDetectionFailureState(failure.message)),
          (textModel) => emit(TextDetectionSuccessState(textModel)),
        );
      } else {
        emit(TextDetectionFailureState('This language is not supported 👀'));
      }
    }
  }

  void _navigateToAudioScreen() {
    emit(NavigateToAudioScreenState());
  }
}
