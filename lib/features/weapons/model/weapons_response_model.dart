import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_model.dart';

part 'weapons_response_model.freezed.dart';
part 'weapons_response_model.g.dart';

@freezed
abstract class WeaponsResponseModel with _$WeaponsResponseModel {
  const factory WeaponsResponseModel({@JsonKey(name: 'data') List<WeaponModel>? weapons}) = _WeaponsResponseModel;

  factory WeaponsResponseModel.fromJson(Map<String, dynamic> json) => _$WeaponsResponseModelFromJson(json);
}
