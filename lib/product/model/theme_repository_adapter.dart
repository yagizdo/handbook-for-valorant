import 'package:core/index.dart';
import 'package:handbook_for_valorant/product/model/theme_entity.dart';

/// Adapts [BaseRepository]<[ThemeEntity]> (app-level ObjectBox entity)
/// to [BaseRepository]<[ThemeModel]> (expected by [ThemeCubit]).
///
/// This bridge exists because [ThemeModel] is defined in the `core` module
/// and is not visible to the app-level ObjectBox code generator.
class ThemeRepositoryAdapter extends BaseRepository<ThemeModel> {
  ThemeRepositoryAdapter(this._inner);
  final BaseRepository<ThemeEntity> _inner;

  static const _validThemes = {'light', 'dark', 'system'};

  @override
  int save(ThemeModel entity) {
    final theme = _validThemes.contains(entity.theme) ? entity.theme : 'system';
    final existing = _inner.getAll().firstOrNull;
    return _inner.save((existing ?? ThemeEntity())..theme = theme);
  }

  @override
  List<int> saveAll(List<ThemeModel> entities) =>
      _inner.saveAll(entities.map((e) => ThemeEntity()..theme = e.theme).toList());

  @override
  ThemeModel? get(int id) {
    final entity = _inner.get(id);
    if (entity == null) return null;
    return ThemeModel()..theme = entity.theme;
  }

  @override
  List<ThemeModel> getAll() => _inner.getAll().map((e) => ThemeModel()..theme = e.theme).toList();

  @override
  bool delete(int id) => _inner.delete(id);

  @override
  int deleteAll() => _inner.deleteAll();
}
