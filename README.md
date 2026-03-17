# أذكاري - Dhikr App 🌙

A beautiful Islamic Dhikr (remembrance) app built with Flutter, inspired by the design you shared. 

## Features

- 📿 **Rich Adhkar Library** — Morning, evening, night, prayer, sleep, and miscellaneous adhkar with Arabic text, translations, and virtues
- 🔢 **Tasbeeh Counter** — Digital prayer beads with haptic feedback, circular progress ring, and animated counting
- 🔒 **App Locking** — Lock distracting apps until you complete your tasbeeh (requires Android Accessibility Service permission)
- 🎨 **Beautiful Dark UI** — Dark theme matching the reference design with green accents
- 🔁 **Customizable Counts** — Choose preset counts (1, 3, 7, 10, 33, 99, 100) or enter a custom number
- ✅ **Completion Screen** — Celebratory screen when tasbeeh is done with app unlocking

## Screens

1. **Home / Adhkar** — Category cards with gradients for each dhikr type
2. **Dhikr List** — Expandable cards with Arabic text, translation, count badge, and "Start Tasbeeh" button
3. **Tasbeeh Setup** — Choose count + select apps to lock
4. **Tasbeeh Counter** — Beautiful circular counter with progress ring and haptic tap
5. **Completion** — Celebration + apps unlocked confirmation

## App Locking Setup (Android)

The app locking feature requires:

### 1. Accessibility Service
- Go to **Settings > Accessibility > Dhikr App**
- Enable the service
- This allows the app to detect when a locked app opens and redirect back

### 2. Usage Stats Permission
- Go to **Settings > Apps > Special app access > Usage access**
- Enable for Dhikr App

### 3. Display Over Other Apps
- Go to **Settings > Apps > Special app access > Display over other apps**
- Enable for Dhikr App

The app will guide you through these permissions when you first try to lock apps.

## Running the App

```bash
# Install dependencies
flutter pub get

# Run on Android
flutter run

# Build APK
flutter build apk --release
```

## Native Android Implementation

The `AppLockService.kt` file contains the Kotlin implementation for the Accessibility Service. To complete the native integration:

1. Add `AppLockAccessibilityService` to your `AndroidManifest.xml`
2. Create `res/xml/accessibility_service_config.xml`  
3. Connect the Flutter Method Channel in `MainActivity.kt`

See `AppLockService.kt` for detailed instructions and code.

## iOS Note

App locking is **not possible on iOS** due to sandbox restrictions. The UI still works — the app locking section will gracefully show an explanation on iOS.

## Tech Stack

- Flutter 3.x
- Dart 3.x
- Platform Channels (Dart ↔ Kotlin)
- Android Accessibility Services API
- SharedPreferences (for saving progress)

## File Structure

```
lib/
├── main.dart
├── theme/
│   └── app_theme.dart
├── models/
│   └── dhikr_model.dart
├── data/
│   └── adhkar_data.dart
├── services/
│   └── app_lock_service.dart
└── screens/
    ├── home_screen.dart
    ├── dhikr_list_screen.dart
    ├── tasbeeh_setup_screen.dart
    ├── tasbeeh_screen.dart
    ├── tasbeeh_counter_screen.dart
    └── completion_screen.dart

android/
└── app/src/main/kotlin/
    └── AppLockService.kt
```
