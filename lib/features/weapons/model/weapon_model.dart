import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:handbook_for_valorant/features/weapons/model/skin_model.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_stats_model.dart';

part 'weapon_model.freezed.dart';
part 'weapon_model.g.dart';

@freezed
abstract class WeaponModel with _$WeaponModel {
  const factory WeaponModel({
    required String uuid,
    required String displayName,
    String? category,
    String? defaultSkinUuid,
    String? displayIcon,
    String? killStreamIcon,
    WeaponStatsModel? weaponStats,
    ShopDataModel? shopData,
    @Default([]) List<SkinModel> skins,
  }) = _WeaponModel;

  factory WeaponModel.fromJson(Map<String, dynamic> json) => _$WeaponModelFromJson(json);
}

@freezed
abstract class ShopDataModel with _$ShopDataModel {
  const factory ShopDataModel({int? cost, String? category, String? categoryText}) = _ShopDataModel;

  factory ShopDataModel.fromJson(Map<String, dynamic> json) => _$ShopDataModelFromJson(json);
}
