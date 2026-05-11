import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/ranks/model/ranks_success_model.dart';

part 'ranks_state.freezed.dart';

@freezed
sealed class RanksState with _$RanksState {
  const factory RanksState.initial() = RanksStateInitial;
  const factory RanksState.loading() = RanksStateLoading;
  const factory RanksState.empty() = RanksStateEmpty;
  const factory RanksState.success(RanksSuccessModel data) = RanksStateSuccess;
  const factory RanksState.error(String errorMessage) = RanksStateError;
}
