package com.example.dhikr_app

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.view.accessibility.AccessibilityEvent
import android.content.SharedPreferences

class AppLockService : AccessibilityService() {

    private lateinit var prefs: SharedPreferences

    override fun onServiceConnected() {
        super.onServiceConnected()
        prefs = getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
        val info = AccessibilityServiceInfo()
        info.eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
        info.notificationTimeout = 100
        serviceInfo = info
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event?.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) return
        val packageName = event.packageName?.toString() ?: return
        if (packageName == "com.example.dhikr_app") return

        val lockEnabled = prefs.getBoolean("flutter.lock_enabled", false)
        if (!lockEnabled) return

        val lockedAppsJson = prefs.getString("flutter.locked_apps", null) ?: return
        val lockedApps = lockedAppsJson
            .removeSurrounding("[", "]")
            .split(",")
            .map { it.trim().removeSurrounding("\"") }
            .filter { it.isNotEmpty() }

        if (lockedApps.contains(packageName)) {
            val intent = Intent(this, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                putExtra("locked_package", packageName)
                putExtra("show_lock_screen", true)
            }
            startActivity(intent)
        }
    }

    override fun onInterrupt() {}
}
