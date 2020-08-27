package com.ahmed63c.tawjihi

import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.view.SurfaceView
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import android.view.WindowManager.LayoutParams
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
       // window.addFlags(LayoutParams.FLAG_SECURE)
    }
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine)
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
//            SurfaceView(applicationContext).setSecure(true)
//        }
//        this.window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
//        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
//    }
}
