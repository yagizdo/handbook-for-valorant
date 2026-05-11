part of 'app_init.dart';

abstract interface class _Initializer {
  const _Initializer._();
  Future<void> make();
}

final class _CacheInitialize implements _Initializer {
  @override
  Future<void> make() async {
    await CacheInit.init();
  }
}

final class _CubitInitialize implements _Initializer {
  @override
  Future<void> make() async {
    BaseContainer.instance.setup();
    BaseContainer.instance.themeCubit.init();
  }
}

final class _LocalizationInitialize implements _Initializer {
  @override
  Future<void> make() async {
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableBuildModes = [];
  }
}

final class _FirebaseInitialize implements _Initializer {
  @override
  Future<void> make() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }
}

final class _MarionetteInitialize implements _Initializer {
  final _logCollector = PrintLogCollector();

  @override
  Future<void> make() async {
    MarionetteBinding.ensureInitialized(MarionetteConfiguration(logCollector: _logCollector));
    ProductLogger.addOutput(_logCollector.addLog);
  }
}

final class _DebugErrorInitialize implements _Initializer {
  @override
  Future<void> make() async {
    if (!kDebugMode) return;

    FlutterError.onError = (details) {
      FlutterError.dumpErrorToConsole(details, forceReport: true);
      ProductLogger.e(
        details.exceptionAsString(),
        tag: 'FlutterError',
        error: details.exception,
        stackTrace: details.stack,
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      ProductLogger.e(error.toString(), tag: 'AsyncError', error: error, stackTrace: stack);
      return true;
    };
  }
}
