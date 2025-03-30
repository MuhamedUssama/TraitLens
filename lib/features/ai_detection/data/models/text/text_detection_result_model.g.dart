// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_detection_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextDetectionResultModel _$TextDetectionResultModelFromJson(
        Map<String, dynamic> json) =>
    TextDetectionResultModel(
      dominantTrait: json['dominant_trait'] as String?,
      traits: json['traits'] == null
          ? null
          : Traits.fromJson(json['traits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TextDetectionResultModelToJson(
        TextDetectionResultModel instance) =>
    <String, dynamic>{
      'dominant_trait': instance.dominantTrait,
      'traits': instance.traits,
    };
