// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Traits _$TraitsFromJson(Map<String, dynamic> json) => Traits(
      agreeablenessA: json[' Agreeableness(A)'] as String?,
      conscientiousnessC: json['Conscientiousness(C)'] as String?,
      extraversionE: json['Extraversion(E)'] as String?,
      neuroticismN: json['Neuroticism(N)'] as String?,
      opennessO: json['Openness(O)'] as String?,
    );

Map<String, dynamic> _$TraitsToJson(Traits instance) => <String, dynamic>{
      ' Agreeableness(A)': instance.agreeablenessA,
      'Conscientiousness(C)': instance.conscientiousnessC,
      'Extraversion(E)': instance.extraversionE,
      'Neuroticism(N)': instance.neuroticismN,
      'Openness(O)': instance.opennessO,
    };
