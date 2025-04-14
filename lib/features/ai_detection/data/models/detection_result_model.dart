import 'package:json_annotation/json_annotation.dart';

import 'traits_model.dart';

part 'detection_result_model.g.dart';

@JsonSerializable()
class DetectionResultModel {
  @JsonKey(name: 'dominant_trait')
  String? dominantTrait;
  Traits? traits;

  DetectionResultModel({this.dominantTrait, this.traits});

  factory DetectionResultModel.fromJson(Map<String, dynamic> json) =>
      _$DetectionResultModelFromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'dominant_trait': dominantTrait,
      'traits': traits?.toJson(),
    };
  }
}
