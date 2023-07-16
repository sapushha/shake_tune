
import 'shake_tune_platform_interface.dart';

class ShakeTune {
  Future<String?> getPlatformVersion() {
    return ShakeTunePlatform.instance.getPlatformVersion();
  }
}
