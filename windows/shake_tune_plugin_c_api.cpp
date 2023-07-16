#include "include/shake_tune/shake_tune_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "shake_tune_plugin.h"

void ShakeTunePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  shake_tune::ShakeTunePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
