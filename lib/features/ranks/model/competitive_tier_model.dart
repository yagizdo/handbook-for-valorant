import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_model.dart';

part 'competitive_tier_model.freezed.dart';
part 'competitive_tier_model.g.dart';

@freezed
abstract class CompetitiveTierModel with _$CompetitiveTierModel {
  const factory CompetitiveTierModel({String? uuid, String? assetObjectName, @Default([]) List<RankModel> tiers}) =
      _CompetitiveTierModel;

  factory CompetitiveTierModel.fromJson(Map<String, dynamic> json) => _$CompetitiveTierModelFromJson(json);
}
