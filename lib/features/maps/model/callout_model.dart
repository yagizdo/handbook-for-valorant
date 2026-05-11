import 'package:freezed_annotation/freezed_annotation.dart';

part 'callout_model.freezed.dart';
part 'callout_model.g.dart';

@freezed
abstract class CalloutModel with _$CalloutModel {
  const factory CalloutModel({String? regionName, String? superRegionName, LocationModel? location}) = _CalloutModel;

  factory CalloutModel.fromJson(Map<String, dynamic> json) => _$CalloutModelFromJson(json);
}

@freezed
abstract class LocationModel with _$LocationModel {
  const factory LocationModel({double? x, double? y}) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
}
