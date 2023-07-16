import 'package:flutter_test/flutter_test.dart';
import 'package:shake_tune/shake_tune.dart';
import 'package:shake_tune/shake_tune_platform_interface.dart';
import 'package:shake_tune/shake_tune_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockShakeTunePlatform
    with MockPlatformInterfaceMixin
    implements ShakeTunePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ShakeTunePlatform initialPlatform = ShakeTunePlatform.instance;

  test('$MethodChannelShakeTune is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelShakeTune>());
  });

  test('getPlatformVersion', () async {
    ShakeTune shakeTunePlugin = ShakeTune();
    MockShakeTunePlatform fakePlatform = MockShakeTunePlatform();
    ShakeTunePlatform.instance = fakePlatform;

    expect(await shakeTunePlugin.getPlatformVersion(), '42');
  });
}
