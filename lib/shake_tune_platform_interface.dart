import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'shake_tune_method_channel.dart';

abstract class ShakeTunePlatform extends PlatformInterface {
  /// Constructs a ShakeTunePlatform.
  ShakeTunePlatform() : super(token: _token);

  static final Object _token = Object();

  static ShakeTunePlatform _instance = MethodChannelShakeTune();

  /// The default instance of [ShakeTunePlatform] to use.
  ///
  /// Defaults to [MethodChannelShakeTune].
  static ShakeTunePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ShakeTunePlatform] when
  /// they register themselves.
  static set instance(ShakeTunePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
