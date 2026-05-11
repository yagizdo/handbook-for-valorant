import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/maps/model/map_model.dart';

part 'maps_response_model.freezed.dart';
part 'maps_response_model.g.dart';

@freezed
abstract class MapsResponseModel with _$MapsResponseModel {
  const factory MapsResponseModel({@JsonKey(name: 'data') List<MapModel>? maps}) = _MapsResponseModel;

  factory MapsResponseModel.fromJson(Map<String, dynamic> json) => _$MapsResponseModelFromJson(json);
}
