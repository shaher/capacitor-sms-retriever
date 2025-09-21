#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(CapacitorSmsRetrieverPlugin, "CapacitorSmsRetriever",
           CAP_PLUGIN_METHOD(present, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(startListening, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(stopListening, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getHashCode, CAPPluginReturnPromise);
)
