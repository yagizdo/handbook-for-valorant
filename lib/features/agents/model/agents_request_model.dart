import 'package:freezed_annotation/freezed_annotation.dart';

part 'agents_request_model.freezed.dart';
part 'agents_request_model.g.dart';

@freezed
abstract class AgentsRequestModel with _$AgentsRequestModel {
  const factory AgentsRequestModel({bool? isPlayableCharacter}) = _AgentsRequestModel;

  factory AgentsRequestModel.fromJson(Map<String, dynamic> json) => _$AgentsRequestModelFromJson(json);
}
