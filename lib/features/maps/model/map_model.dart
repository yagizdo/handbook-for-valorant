import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/maps/model/callout_model.dart';

part 'map_model.freezed.dart';
part 'map_model.g.dart';

@freezed
abstract class MapModel with _$MapModel {
  const factory MapModel({
    required String uuid,
    required String displayName,
    String? coordinates,
    String? displayIcon,
    String? listViewIcon,
    String? listViewIconTall,
    String? splash,
    String? mapUrl,
    @Default([]) List<CalloutModel> callouts,
  }) = _MapModel;

  factory MapModel.fromJson(Map<String, dynamic> json) => _$MapModelFromJson(json);
}
