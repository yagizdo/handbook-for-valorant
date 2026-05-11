import 'package:freezed_annotation/freezed_annotation.dart';

part 'ability_model.freezed.dart';
part 'ability_model.g.dart';

@freezed
abstract class AbilityModel with _$AbilityModel {
  const factory AbilityModel({String? slot, String? displayName, String? description, String? displayIcon}) =
      _AbilityModel;

  factory AbilityModel.fromJson(Map<String, dynamic> json) => _$AbilityModelFromJson(json);
}
