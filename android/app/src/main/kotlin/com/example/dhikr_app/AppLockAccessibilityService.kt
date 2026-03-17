package com.example.dhikr_app

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.view.accessibility.AccessibilityEvent

class AppLockAccessibilityService : AccessibilityService() {

    companion object {
        val lockedPackages = mutableSetOf<String>()
        var isSessionActive = false
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        val info = AccessibilityServiceInfo()
        info.eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
        info.notificationTimeout = 100
        serviceInfo = info
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (!isSessionActive) return
        if (event?.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) return

        val packageName = event.packageName?.toString() ?: return

        // Don't block our own app or the home screen
        if (packageName == "com.example.dhikr_app") return
        if (packageName == "com.android.launcher" || packageName.contains("launcher")) return

        if (lockedPackages.contains(packageName)) {
            // Press home to exit the locked app
            performGlobalAction(GLOBAL_ACTION_HOME)

            // Bring the Dhikr app back to foreground
            val intent = Intent(applicationContext, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP
                putExtra("blocked_app", packageName)
            }
            startActivity(intent)
        }
    }

    override fun onInterrupt() {}
}
