import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/maps/model/maps_success_model.dart';

part 'map_state.freezed.dart';

@freezed
sealed class MapState with _$MapState {
  const factory MapState.initial() = MapStateInitial;
  const factory MapState.loading() = MapStateLoading;
  const factory MapState.empty() = MapStateEmpty;
  const factory MapState.success(MapsSuccessModel data) = MapStateSuccess;
  const factory MapState.error(String errorMessage) = MapStateError;
}
