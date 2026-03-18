package com.example.dhikr_app

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.view.accessibility.AccessibilityEvent

class AppLockService : AccessibilityService() {

    companion object {
        const val PREFS_NAME = "app_lock_prefs"
        const val KEY_LOCK_ENABLED = "lock_enabled"
        const val KEY_LOCKED_APPS = "locked_apps"
        var instance: AppLockService? = null
    }

    private lateinit var prefs: SharedPreferences

    override fun onServiceConnected() {
        super.onServiceConnected()
        instance = this
        prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val info = AccessibilityServiceInfo().apply {
            eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
            notificationTimeout = 100
        }
        serviceInfo = info
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event?.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) return
        val lockEnabled = prefs.getBoolean(KEY_LOCK_ENABLED, false)
        if (!lockEnabled) return
        val packageName = event.packageName?.toString() ?: return
        if (packageName == applicationContext.packageName) return
        val lockedAppsStr = prefs.getString(KEY_LOCKED_APPS, "") ?: ""
        val lockedApps = lockedAppsStr.split(",").filter { it.isNotEmpty() }
        if (lockedApps.contains(packageName)) {
            val intent = packageManager.getLaunchIntentForPackage(applicationContext.packageName)
            intent?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            startActivity(intent)
        }
    }

    override fun onInterrupt() { instance = null }
    override fun onDestroy() { super.onDestroy(); instance = null }
}
