import 'package:freezed_annotation/freezed_annotation.dart';

part 'weapon_stats_model.freezed.dart';
part 'weapon_stats_model.g.dart';

@freezed
abstract class WeaponStatsModel with _$WeaponStatsModel {
  const factory WeaponStatsModel({
    double? fireRate,
    int? magazineSize,
    double? runSpeedMultiplier,
    double? equipTimeSeconds,
    double? reloadTimeSeconds,
    double? firstBulletAccuracy,
    int? shotgunPelletCount,
    String? wallPenetration,
    String? feature,
    String? fireMode,
    String? altFireType,
    AdsStatsModel? adsStats,
    @Default([]) List<DamageRangeModel> damageRanges,
  }) = _WeaponStatsModel;

  factory WeaponStatsModel.fromJson(Map<String, dynamic> json) => _$WeaponStatsModelFromJson(json);
}

@freezed
abstract class AdsStatsModel with _$AdsStatsModel {
  const factory AdsStatsModel({
    double? zoomMultiplier,
    double? fireRate,
    double? runSpeedMultiplier,
    int? burstCount,
    double? firstBulletAccuracy,
  }) = _AdsStatsModel;

  factory AdsStatsModel.fromJson(Map<String, dynamic> json) => _$AdsStatsModelFromJson(json);
}

@freezed
abstract class DamageRangeModel with _$DamageRangeModel {
  const factory DamageRangeModel({
    double? rangeStartMeters,
    double? rangeEndMeters,
    double? headDamage,
    double? bodyDamage,
    double? legDamage,
  }) = _DamageRangeModel;

  factory DamageRangeModel.fromJson(Map<String, dynamic> json) => _$DamageRangeModelFromJson(json);
}
