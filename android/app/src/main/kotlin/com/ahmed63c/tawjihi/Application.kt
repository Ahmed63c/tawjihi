package com.ahmed63c.tawjihi

import androidx.annotation.CallSuper
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry


class Application : FlutterApplication() {
    @CallSuper
    override fun onCreate() {
        super.onCreate()

        //interfaces
        //, PluginRegistry.PluginRegistrantCallback
      //  FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

//    override fun registerWith(pluginRegistry: PluginRegistry) {
//        FirebaseMessagingPlugin.registerWith(pluginRegistry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
//    }
}