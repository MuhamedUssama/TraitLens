import 'package:json_annotation/json_annotation.dart';

import 'traits_model.dart';

part 'text_detection_result_model.g.dart';

@JsonSerializable()
class TextDetectionResultModel {
  @JsonKey(name: 'dominant_trait')
  String? dominantTrait;
  Traits? traits;

  TextDetectionResultModel({this.dominantTrait, this.traits});

  factory TextDetectionResultModel.fromJson(Map<String, dynamic> json) =>
      _$TextDetectionResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$TextDetectionResultModelToJson(this);
}
