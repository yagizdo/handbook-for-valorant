import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_model.dart';

part 'weapons_success_model.freezed.dart';

@freezed
abstract class WeaponsSuccessModel with _$WeaponsSuccessModel {
  const factory WeaponsSuccessModel({required List<WeaponModel> weapons}) = _WeaponsSuccessModel;
}
