import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'shake_tune_platform_interface.dart';

/// An implementation of [ShakeTunePlatform] that uses method channels.
class MethodChannelShakeTune extends ShakeTunePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('shake_tune');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
