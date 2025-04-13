import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/utils/image_picker_utils.dart';
import 'package:trait_lens/features/ai_detection/domain/usecases/send_image_usecase.dart';
import 'package:trait_lens/features/ai_detection/view/view_models/image_view_model/image_detection_states.dart';

@injectable
class ImageDetectionViewModel extends Cubit<ImageDetectionStates> {
  final SendImageUsecase _usecase;

  @factoryMethod
  ImageDetectionViewModel(this._usecase) : super(ImageDetectionInitialState());

  File? imageFile;

  Future<void> sendImage() async {
    if (imageFile != null) {
      emit(ImageDetectionLoadingState());

      final result = await _usecase(imageFile: imageFile!);

      result.fold(
        (error) => emit(ImageDetectionErrorState(error.toString())),
        (detectionResultModel) =>
            emit(ImageDetectionSuccessState(detectionResultModel)),
      );
    } else {
      emit(ImageDetectionErrorState("Please select an image first."));
    }
  }

  Future<void> clickOnCameraButton() async {
    imageFile = await ImagePickerUtils.cameraPicker();
    if (imageFile != null) {
      emit(ImageSelectedState(imageFile!));
    }
  }

  Future<void> clickOnGalleryButton() async {
    imageFile = await ImagePickerUtils.galleryPicker();
    if (imageFile != null) {
      emit(ImageSelectedState(imageFile!));
    }
  }
}
