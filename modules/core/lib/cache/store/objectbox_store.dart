import 'package:core/constants/cache_constants.dart';
import 'package:core/objectbox.g.dart' as core_obx;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Signature for an ObjectBox store opener function.
///
/// Both the core module and the main app generate an `openStore` function
/// in their respective `objectbox.g.dart`. Pass the app-level opener to
/// [ObjectBoxStore.init] so that all entity types are registered.
typedef StoreOpener = Future<core_obx.Store> Function({String? directory});

/// Manages the singleton ObjectBox [Store] instance.
///
/// Call [init] once during app startup before accessing [instance].
/// Uses a static reference to survive hot restarts in debug mode.
class ObjectBoxStore {
  ObjectBoxStore._();

  static core_obx.Store? _store;

  /// Opens the ObjectBox Store. Safe to call multiple times —
  /// returns the existing instance if already open.
  ///
  /// [openStore] — the generated `openStore` function from the package
  /// whose `objectbox.g.dart` contains **all** entity types the app needs.
  /// Defaults to the core module's opener (ThemeModel only).
  ///
  /// Pass [directoryPath] to override the default location
  /// (useful for testing with in-memory stores).
  static Future<core_obx.Store> init({StoreOpener openStore = core_obx.openStore, String? directoryPath}) async {
    if (_store != null && !_store!.isClosed()) return _store!;

    if (directoryPath != null) {
      _store = await openStore(directory: directoryPath);
    } else {
      final docsDir = await getApplicationDocumentsDirectory();
      _store = await openStore(directory: p.join(docsDir.path, CacheConstants.objectBoxDirectory));
    }
    return _store!;
  }

  /// Returns the opened Store instance.
  /// Throws if [init] has not been called.
  static core_obx.Store get instance {
    assert(_store != null && !_store!.isClosed(), 'ObjectBoxStore.init() must be called before accessing instance');
    return _store!;
  }
}
