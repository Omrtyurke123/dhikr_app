package com.dhikrapp.applock

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.view.WindowManager
import android.view.accessibility.AccessibilityEvent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * AppLockAccessibilityService
 * 
 * This Accessibility Service monitors which app is in the foreground.
 * When a locked app is detected, it shows an overlay blocking access.
 * 
 * SETUP REQUIRED:
 * 1. Add to AndroidManifest.xml:
 *    <service
 *        android:name=".AppLockAccessibilityService"
 *        android:exported="true"
 *        android:permission="android.permission.BIND_ACCESSIBILITY_SERVICE">
 *        <intent-filter>
 *            <action android:name="android.accessibilityservice.AccessibilityService"/>
 *        </intent-filter>
 *        <meta-data
 *            android:name="android.accessibilityservice"
 *            android:resource="@xml/accessibility_service_config"/>
 *    </service>
 * 
 * 2. Create res/xml/accessibility_service_config.xml:
 *    <?xml version="1.0" encoding="utf-8"?>
 *    <accessibility-service
 *        xmlns:android="http://schemas.android.com/apk/res/android"
 *        android:accessibilityEventTypes="typeWindowStateChanged"
 *        android:accessibilityFeedbackType="feedbackGeneric"
 *        android:accessibilityFlags="flagDefault"
 *        android:canRetrieveWindowContent="false"
 *        android:description="@string/accessibility_description"
 *        android:notificationTimeout="100"/>
 * 
 * 3. Direct user to Settings > Accessibility > Dhikr App > Enable
 */
class AppLockAccessibilityService : AccessibilityService() {

    companion object {
        val lockedPackages = mutableSetOf<String>()
        var isSessionActive = false
        var CHANNEL = "com.dhikrapp/app_lock"
    }

    private var windowManager: WindowManager? = null

    override fun onServiceConnected() {
        super.onServiceConnected()
        val info = AccessibilityServiceInfo()
        info.eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
        info.notificationTimeout = 100
        serviceInfo = info
        windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (!isSessionActive) return
        if (event?.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) return

        val packageName = event.packageName?.toString() ?: return

        if (lockedPackages.contains(packageName)) {
            // Block this app - navigate back or show overlay
            performGlobalAction(GLOBAL_ACTION_HOME)
            showBlockingOverlay(packageName)
        }
    }

    private fun showBlockingOverlay(blockedApp: String) {
        // In a full implementation, inflate a custom view showing:
        // - Message: "Complete your Tasbeeh first!"
        // - Show current progress
        // - Button to go back to the Dhikr app
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP
            putExtra("show_locked_message", true)
            putExtra("blocked_app", blockedApp)
        }
        startActivity(intent)
    }

    override fun onInterrupt() {}
}

/**
 * Flutter Method Channel Bridge
 * Add to MainActivity.kt configureFlutterEngine:
 * 
 * MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.dhikrapp/app_lock")
 *     .setMethodCallHandler { call, result ->
 *         when (call.method) {
 *             "lockApps" -> {
 *                 val packages = call.argument<List<String>>("packages") ?: emptyList()
 *                 AppLockAccessibilityService.lockedPackages.clear()
 *                 AppLockAccessibilityService.lockedPackages.addAll(packages)
 *                 AppLockAccessibilityService.isSessionActive = true
 *                 result.success(true)
 *             }
 *             "unlockApps" -> {
 *                 AppLockAccessibilityService.lockedPackages.clear()
 *                 AppLockAccessibilityService.isSessionActive = false
 *                 result.success(true)
 *             }
 *             "isAccessibilityEnabled" -> {
 *                 val am = getSystemService(Context.ACCESSIBILITY_SERVICE) as android.view.accessibility.AccessibilityManager
 *                 result.success(am.isEnabled)
 *             }
 *             "openAccessibilitySettings" -> {
 *                 startActivity(Intent(android.provider.Settings.ACTION_ACCESSIBILITY_SETTINGS))
 *                 result.success(true)
 *             }
 *             else -> result.notImplemented()
 *         }
 *     }
 */
