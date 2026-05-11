/// Generic repository interface for local data persistence.
///
/// Provides CRUD operations for any entity type [T].
/// ObjectBox's `put()` is an upsert: id == 0 inserts, id > 0 updates.
abstract class BaseRepository<T> {
  /// Saves an entity. Returns the assigned ID.
  /// If [entity] has id == 0, it inserts. If id > 0, it updates.
  int save(T entity);

  /// Saves multiple entities. Returns list of assigned IDs.
  List<int> saveAll(List<T> entities);

  /// Gets an entity by [id]. Returns null if not found.
  T? get(int id);

  /// Gets all entities of this type.
  List<T> getAll();

  /// Deletes an entity by [id]. Returns true if it existed.
  bool delete(int id);

  /// Deletes all entities of this type. Returns count removed.
  int deleteAll();
}
