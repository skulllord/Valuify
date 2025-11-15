# ⚠️ FIREBASE SETUP REQUIRED

## Current Status

✅ Flutter is installed (v3.38.1)
✅ Dependencies are installed
✅ Devices available: Windows, Chrome, Edge

❌ **Firebase is NOT configured** - App will crash without it!

## Why Firebase is Required

Valuify uses Firebase for:
- User authentication (login/signup)
- Database (storing transactions, categories, budgets)
- File storage (receipt images)

**The app CANNOT run without Firebase setup.**

## Quick Firebase Setup (15 minutes)

### Step 1: Create Firebase Project

1. Go to: https://console.firebase.google.com/
2. Click "Add project"
3. Name: "Valuify"
4. Disable Google Analytics (optional)
5. Click "Create project"

### Step 2: Enable Authentication

1. In Firebase Console, click "Authentication"
2. Click "Get started"
3. Click "Email/Password" → Enable → Save
4. Click "Google" → Enable → Add support email → Save

### Step 3: Create Firestore Database

1. Click "Firestore Database" in left menu
2. Click "Create database"
3. Select "Start in production mode"
4. Choose location (closest to you)
5. Click "Enable"

### Step 4: Update Firestore Rules

1. Go to "Firestore Database" → "Rules" tab
2. Replace with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      match /{document=**} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

3. Click "Publish"

### Step 5: Enable Storage

1. Click "Storage" in left menu
2. Click "Get started"
3. Click "Next" → "Done"

### Step 6: Update Storage Rules

1. Go to "Storage" → "Rules" tab
2. Replace with:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /receipts/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

3. Click "Publish"

### Step 7: Add Android App to Firebase

1. In Project Overview, click the Android icon (</> or robot icon)
2. Enter package name: `com.valuify.app`
3. App nickname: "Valuify"
4. Click "Register app"
5. **Download `google-services.json`**
6. Click "Next" → "Next" → "Continue to console"

### Step 8: Add Configuration File

**CRITICAL STEP:**

1. Take the downloaded `google-services.json` file
2. Place it in: `D:\Valuify\android\app\google-services.json`

### Step 9: Run the App

```powershell
flutter run -d windows
```

Or for web:
```powershell
flutter run -d chrome
```

## Alternative: Use FlutterFire CLI (Easier)

```powershell
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase automatically
flutterfire configure
```

This will:
- Create Firebase project (or use existing)
- Generate configuration files
- Set up for all platforms

## What Happens If You Run Without Firebase?

The app will:
1. Start loading
2. Show error: "Default FirebaseApp is not initialized"
3. Crash or show error screen

## Quick Test (After Firebase Setup)

1. Run: `flutter run -d windows`
2. App opens
3. Click "Sign Up"
4. Enter email, password, name
5. Click "Create Account"
6. You should be logged in and see the dashboard

## Need Help?

### Option 1: Follow Video Tutorial
Search YouTube: "Flutter Firebase Setup 2024"

### Option 2: Use Firebase Documentation
https://firebase.google.com/docs/flutter/setup

### Option 3: Check Detailed Guide
Open `FIREBASE_SETUP.md` in this project

## Current Commands You Can Run

```powershell
# Check Flutter setup
flutter doctor

# Check available devices
flutter devices

# Check available emulators
flutter emulators

# Analyze code (without running)
flutter analyze

# Format code
flutter format .
```

## After Firebase Setup

Once you add `google-services.json`, run:

```powershell
# For Windows desktop
flutter run -d windows

# For Chrome browser
flutter run -d chrome

# For Android emulator (if you have one)
flutter emulators --launch <emulator_id>
flutter run -d android
```

## Summary

**To run Valuify:**

1. ✅ Flutter installed
2. ✅ Dependencies installed
3. ❌ **Firebase setup needed** ← YOU ARE HERE
4. ⏳ Add `google-services.json`
5. ⏳ Run `flutter run -d windows`

**Estimated time to complete Firebase setup: 15 minutes**

---

**Ready to set up Firebase?** Follow the steps above or check `FIREBASE_SETUP.md` for more details!
