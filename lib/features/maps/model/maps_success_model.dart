import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/maps/model/map_model.dart';

part 'maps_success_model.freezed.dart';

@freezed
abstract class MapsSuccessModel with _$MapsSuccessModel {
  const factory MapsSuccessModel({required List<MapModel> maps}) = _MapsSuccessModel;
}
