import 'package:core/cache/abstract/base_repository.dart';
import 'package:objectbox/objectbox.dart';

/// Generic ObjectBox implementation of [BaseRepository].
///
/// Receives a [Store] and extracts the typed [Box] internally.
/// ObjectBox's `put()` handles both insert (id == 0) and update (id > 0).
class ObjectBoxRepository<T> extends BaseRepository<T> {
  ObjectBoxRepository(Store store) : _box = store.box<T>();
  final Box<T> _box;

  @override
  int save(T entity) => _box.put(entity);

  @override
  List<int> saveAll(List<T> entities) => _box.putMany(entities);

  @override
  T? get(int id) => _box.get(id);

  @override
  List<T> getAll() => _box.getAll();

  @override
  bool delete(int id) => _box.remove(id);

  @override
  int deleteAll() => _box.removeAll();
}
