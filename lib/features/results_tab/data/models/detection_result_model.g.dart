// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detection_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetectionResultModel _$DetectionResultModelFromJson(
        Map<String, dynamic> json) =>
    DetectionResultModel(
      dominantTrait: json['dominant_trait'] as String?,
      traits: json['traits'] == null
          ? null
          : Traits.fromJson(json['traits'] as Map<String, dynamic>),
    );
