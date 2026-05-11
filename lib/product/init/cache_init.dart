import 'package:core/index.dart';
import 'package:handbook_for_valorant/objectbox.g.dart' as app_obx;

final class CacheInit {
  CacheInit._();

  static Future<void> init() async {
    await ObjectBoxStore.init(openStore: app_obx.openStore);
  }
}
