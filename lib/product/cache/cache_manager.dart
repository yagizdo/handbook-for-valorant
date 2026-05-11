import 'package:core/cache/abstract/base_repository.dart';

final class CacheManager {
  CacheManager(this._repositories);

  final List<BaseRepository<dynamic>> _repositories;

  void clearAll() {
    for (final repo in _repositories) {
      repo.deleteAll();
    }
  }
}
