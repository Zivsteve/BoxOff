package com.boxoff.app

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.os.Bundle
import android.view.View
import android.view.Window
import android.view.WindowManager
import android.os.Build

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    drawUnderSystemUi()
  }

  override fun onPostResume() {
		super.onPostResume()
		drawUnderSystemUi()
	}

  fun drawUnderSystemUi() {
		if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
			val window: Window = getWindow()
			window.setStatusBarColor(0x00000000)
			window.setNavigationBarColor(0x00000000)
			window.getDecorView()
				.setSystemUiVisibility(
					View.SYSTEM_UI_FLAG_LAYOUT_STABLE or
					View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
					View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)
		}
	}
}
