import 'package:core/constants/platform_constants.dart';
import 'package:core/core_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [CorePlatform] that uses method channels.
class MethodChannelCore extends CorePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(PlatformConstants.methodChannelName);

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(PlatformConstants.getPlatformVersionMethod);
    return version;
  }
}
