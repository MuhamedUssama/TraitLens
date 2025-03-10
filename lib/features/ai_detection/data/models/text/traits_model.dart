import 'package:json_annotation/json_annotation.dart';

part 'traits_model.g.dart';

@JsonSerializable()
class Traits {
  @JsonKey(name: ' Agreeableness(A)')
  String? agreeablenessA;

  @JsonKey(name: 'Conscientiousness(C)')
  String? conscientiousnessC;

  @JsonKey(name: 'Extraversion(E)')
  String? extraversionE;

  @JsonKey(name: 'Neuroticism(N)')
  String? neuroticismN;

  @JsonKey(name: 'Openness(O)')
  String? opennessO;

  Traits({
    this.agreeablenessA,
    this.conscientiousnessC,
    this.extraversionE,
    this.neuroticismN,
    this.opennessO,
  });

  factory Traits.fromJson(Map<String, dynamic> json) => _$TraitsFromJson(json);

  Map<String, dynamic> toJson() => _$TraitsToJson(this);
}
