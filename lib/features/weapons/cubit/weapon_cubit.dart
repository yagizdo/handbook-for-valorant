import 'package:core/logger/product_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/weapons/cubit/weapon_state.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapons_success_model.dart';
import 'package:handbook_for_valorant/features/weapons/service/weapon_service.dart';
import 'package:handbook_for_valorant/product/constants/app_constants.dart';
import 'package:handbook_for_valorant/product/locator/base_cubit.dart';

class WeaponCubit extends Cubit<WeaponState> with BaseCubit<WeaponState> {
  WeaponCubit({required WeaponService weaponService})
    : _weaponService = weaponService,
      super(const WeaponState.initial());
  final WeaponService _weaponService;

  Future<void> loadWeapons({bool forceRefresh = false}) async {
    if (!forceRefresh && state is WeaponStateSuccess) return;

    emit(const WeaponState.loading());

    try {
      final weapons = await _weaponService.getWeapons();

      if (weapons.isEmpty) {
        safeEmit(const WeaponState.empty());
        return;
      }

      safeEmit(WeaponState.success(WeaponsSuccessModel(weapons: weapons)));
    } on Exception catch (e) {
      ProductLogger.e(e.toString(), tag: AppConstants.weaponCubitLogTag);
      safeEmit(WeaponState.error(LocaleKeys.weapons_empty.tr()));
    }
  }
}
