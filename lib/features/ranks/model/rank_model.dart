import 'package:freezed_annotation/freezed_annotation.dart';

part 'rank_model.freezed.dart';
part 'rank_model.g.dart';

@freezed
abstract class RankModel with _$RankModel {
  const factory RankModel({
    int? tier,
    String? tierName,
    String? division,
    String? divisionName,
    String? color,
    String? backgroundColor,
    String? smallIcon,
    String? largeIcon,
    String? rankTriangleDownIcon,
    String? rankTriangleUpIcon,
  }) = _RankModel;

  factory RankModel.fromJson(Map<String, dynamic> json) => _$RankModelFromJson(json);
}
