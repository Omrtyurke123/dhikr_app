package com.example.dhikr_app

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent

class AppLockService : AccessibilityService() {
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {}
    override fun onInterrupt() {}
}
