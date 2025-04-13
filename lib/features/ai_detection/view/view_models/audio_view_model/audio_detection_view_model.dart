import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/features/ai_detection/domain/usecases/send_audio_usecase.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/audio_view_model/audio_detection_states.dart';

@injectable
class AudioDetectionViewModel extends Cubit<AudioDetectionStates> {
  final SendAudioUsecase _audioUsecase;

  @factoryMethod
  AudioDetectionViewModel(this._audioUsecase)
      : super(AudioDetectionInitialState());

  final AudioRecorder _recorder = AudioRecorder();

  String? _audioPath;
  File? _audioFile;

  Future<void> recordAndSendAudio() async {
    final micStatus = await Permission.microphone.status;
    if (!micStatus.isGranted) {
      final result = await Permission.microphone.request();
      if (!result.isGranted) {
        emit(AudioDetectionPermissionDeniedState(
            "Microphone permission denied"));
        return;
      }
    }

    emit(AudioDetectionRecordingState());

    try {
      final Directory dir = await getTemporaryDirectory();
      _audioPath =
          '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.wav';

      await _recorder.start(
        path: _audioPath!,
        const RecordConfig(
          encoder: AudioEncoder.wav,
          bitRate: 128000,
          sampleRate: 44100,
        ),
      );

      await Future.delayed(const Duration(seconds: 15));
      await _recorder.stop();

      _audioFile = File(_audioPath!);

      if (_audioFile != null && await _audioFile!.exists()) {
        emit(AudioDetectionLoadingState());

        final result = await _audioUsecase(audioFile: _audioFile!);

        result.fold(
          (failure) async {
            emit(AudioDetectionErrorState(failure.message));
            await _audioFile?.delete();
          },
          (model) {
            emit(AudioDetectionSuccessState(model));
          },
        );
      } else {
        emit(AudioDetectionErrorState("No audio file found"));
      }
    } catch (error) {
      emit(AudioDetectionErrorState("Error recording audio: $error"));
    }
  }
}
