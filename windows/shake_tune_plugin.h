#ifndef FLUTTER_PLUGIN_SHAKE_TUNE_PLUGIN_H_
#define FLUTTER_PLUGIN_SHAKE_TUNE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace shake_tune {

class ShakeTunePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ShakeTunePlugin();

  virtual ~ShakeTunePlugin();

  // Disallow copy and assign.
  ShakeTunePlugin(const ShakeTunePlugin&) = delete;
  ShakeTunePlugin& operator=(const ShakeTunePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace shake_tune

#endif  // FLUTTER_PLUGIN_SHAKE_TUNE_PLUGIN_H_
