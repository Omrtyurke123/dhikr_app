package com.example.dhikr_app

import android.content.Intent
import android.provider.Settings
import android.view.accessibility.AccessibilityManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.dhikrapp/app_lock"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "lockApps" -> {
                        val packages = call.argument<List<String>>("packages") ?: emptyList()
                        AppLockAccessibilityService.lockedPackages.clear()
                        AppLockAccessibilityService.lockedPackages.addAll(packages)
                        AppLockAccessibilityService.isSessionActive = true
                        result.success(true)
                    }
                    "unlockApps" -> {
                        AppLockAccessibilityService.lockedPackages.clear()
                        AppLockAccessibilityService.isSessionActive = false
                        result.success(true)
                    }
                    "isAccessibilityEnabled" -> {
                        val am = getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
                        result.success(am.isEnabled)
                    }
                    "openAccessibilitySettings" -> {
                        startActivity(Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS))
                        result.success(true)
                    }
                    "canDrawOverlays" -> {
                        result.success(Settings.canDrawOverlays(this))
                    }
                    "requestUsageStatsPermission" -> {
                        startActivity(Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS))
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
