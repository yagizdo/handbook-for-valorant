import 'package:core/logger/product_logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/firebase_options.dart';
import 'package:handbook_for_valorant/product/config/product_bloc_observer.dart';
import 'package:handbook_for_valorant/product/init/cache_init.dart';
import 'package:handbook_for_valorant/product/locator/base_container.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

part 'initializers.dart';

class AppInit {
  AppInit._();

  static Future<void> make() async {
    if (!kDebugMode) {
      WidgetsFlutterBinding.ensureInitialized();
    } else {
      await _MarionetteInitialize().make();
    }
    await _DebugErrorInitialize().make();
    Bloc.observer = ProductBlocObserver();
    await _CacheInitialize().make();
    await _CubitInitialize().make();
    await _LocalizationInitialize().make();
    await _FirebaseInitialize().make();
  }
}
