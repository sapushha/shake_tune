//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <shake_tune/shake_tune_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) shake_tune_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ShakeTunePlugin");
  shake_tune_plugin_register_with_registrar(shake_tune_registrar);
}
