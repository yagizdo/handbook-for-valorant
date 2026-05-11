import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapons_success_model.dart';

part 'weapon_state.freezed.dart';

@freezed
sealed class WeaponState with _$WeaponState {
  const factory WeaponState.initial() = WeaponStateInitial;
  const factory WeaponState.loading() = WeaponStateLoading;
  const factory WeaponState.empty() = WeaponStateEmpty;
  const factory WeaponState.success(WeaponsSuccessModel data) = WeaponStateSuccess;
  const factory WeaponState.error(String errorMessage) = WeaponStateError;
}
