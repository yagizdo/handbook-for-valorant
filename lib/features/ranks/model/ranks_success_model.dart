import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_model.dart';

part 'ranks_success_model.freezed.dart';

@freezed
abstract class RanksSuccessModel with _$RanksSuccessModel {
  const factory RanksSuccessModel({required List<RankModel> allRanks}) = _RanksSuccessModel;
}
