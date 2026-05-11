import 'package:freezed_annotation/freezed_annotation.dart';

part 'skin_model.freezed.dart';
part 'skin_model.g.dart';

@freezed
abstract class SkinModel with _$SkinModel {
  const factory SkinModel({
    required String uuid,
    required String displayName,
    String? themeUuid,
    String? contentTierUuid,
    String? displayIcon,
    String? wallpaper,
    @Default([]) List<ChromaModel> chromas,
    @Default([]) List<LevelModel> levels,
  }) = _SkinModel;

  factory SkinModel.fromJson(Map<String, dynamic> json) => _$SkinModelFromJson(json);
}

@freezed
abstract class ChromaModel with _$ChromaModel {
  const factory ChromaModel({
    required String uuid,
    String? displayName,
    String? displayIcon,
    String? fullRender,
    String? swatch,
    String? streamedVideo,
  }) = _ChromaModel;

  factory ChromaModel.fromJson(Map<String, dynamic> json) => _$ChromaModelFromJson(json);
}

@freezed
abstract class LevelModel with _$LevelModel {
  const factory LevelModel({
    required String uuid,
    String? displayName,
    String? levelItem,
    String? displayIcon,
    String? streamedVideo,
  }) = _LevelModel;

  factory LevelModel.fromJson(Map<String, dynamic> json) => _$LevelModelFromJson(json);
}
