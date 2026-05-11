import 'package:core/logger/product_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/maps/cubit/map_state.dart';
import 'package:handbook_for_valorant/features/maps/model/maps_success_model.dart';
import 'package:handbook_for_valorant/features/maps/service/map_service.dart';
import 'package:handbook_for_valorant/product/constants/app_constants.dart';
import 'package:handbook_for_valorant/product/locator/base_cubit.dart';

class MapCubit extends Cubit<MapState> with BaseCubit<MapState> {
  MapCubit({required MapService mapService}) : _mapService = mapService, super(const MapState.initial());
  final MapService _mapService;

  Future<void> loadMaps() async {
    emit(const MapState.loading());

    try {
      final maps = await _mapService.getMaps();

      if (maps.isEmpty) {
        safeEmit(const MapState.empty());
        return;
      }

      safeEmit(MapState.success(MapsSuccessModel(maps: maps)));
    } on Exception catch (e) {
      ProductLogger.e(e.toString(), tag: AppConstants.mapCubitLogTag);
      safeEmit(MapState.error(LocaleKeys.maps_empty.tr()));
    }
  }
}
