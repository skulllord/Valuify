# How to Run Valuify Project

## ⚠️ Flutter Not Installed

Flutter is not currently installed on your system. Follow these steps to install and run the project.

## Step 1: Install Flutter

### For Windows:

1. **Download Flutter SDK**
   - Go to: https://docs.flutter.dev/get-started/install/windows
   - Download the latest stable Flutter SDK (zip file)
   - Extract to a location like `C:\src\flutter`

2. **Add Flutter to PATH**
   - Search for "Environment Variables" in Windows
   - Click "Environment Variables"
   - Under "User variables", find "Path"
   - Click "Edit" → "New"
   - Add: `C:\src\flutter\bin` (or your Flutter location)
   - Click "OK" on all dialogs

3. **Verify Installation**
   ```powershell
   flutter doctor
   ```

4. **Install Required Tools**
   - Android Studio: https://developer.android.com/studio
   - Or VS Code with Flutter extension

### Alternative: Use Chocolatey (Windows Package Manager)

```powershell
# Install Chocolatey first (if not installed)
# Then run:
choco install flutter
```

## Step 2: Install Dependencies

Once Flutter is installed:

```bash
# Navigate to project directory
cd Valuify

# Get Flutter packages
flutter pub get
```

## Step 3: Set Up Firebase (CRITICAL)

⚠️ **The app will NOT work without Firebase setup!**

### Quick Firebase Setup:

1. **Go to Firebase Console**
   - Visit: https://console.firebase.google.com/
   - Click "Add project"
   - Name: "Valuify"

2. **Enable Authentication**
   - Go to Authentication → Get Started
   - Enable "Email/Password"
   - Enable "Google"

3. **Create Firestore Database**
   - Go to Firestore Database → Create database
   - Start in production mode
   - Choose location

4. **Enable Storage**
   - Go to Storage → Get Started
   - Use default rules

5. **Add Android App**
   - Click Android icon in Project Overview
   - Package name: `com.valuify.app`
   - Download `google-services.json`
   - Place in: `android/app/google-services.json`

6. **Set Firestore Rules**
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

7. **Set Storage Rules**
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

## Step 4: Run the App

### Option A: Using Android Emulator

1. **Start Android Emulator**
   - Open Android Studio
   - Tools → Device Manager
   - Create/Start a virtual device

2. **Run the app**
   ```bash
   flutter run
   ```

### Option B: Using Physical Device

1. **Enable USB Debugging on your Android phone**
   - Settings → About Phone → Tap "Build Number" 7 times
   - Settings → Developer Options → Enable "USB Debugging"
   - Connect phone via USB

2. **Check device is connected**
   ```bash
   flutter devices
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Option C: Build APK and Install

```bash
# Build debug APK
flutter build apk --debug

# Install on connected device
flutter install

# Or manually install the APK from:
# build/app/outputs/flutter-apk/app-debug.apk
```

## Step 5: Test the App

1. **Sign Up**
   - Open the app
   - Click "Sign Up"
   - Enter email, password, name
   - Or use "Continue with Google"

2. **Add Transaction**
   - Tap the "+" button
   - Select Income or Expense
   - Choose category
   - Enter amount
   - Save

3. **Explore Features**
   - View dashboard with charts
   - Set budgets
   - Generate reports
   - Change theme in settings

## Troubleshooting

### "Flutter not found" after installation
```powershell
# Close and reopen terminal/PowerShell
# Or add to PATH manually and restart
```

### "No devices found"
```bash
# Check connected devices
flutter devices

# For emulator, start it from Android Studio first
```

### "Gradle build failed"
```bash
flutter clean
flutter pub get
flutter run
```

### "Firebase not initialized"
- Make sure `google-services.json` is in `android/app/`
- Check package name matches: `com.valuify.app`
- Verify Firebase services are enabled

### "Google Sign-In failed"
- Add SHA-1 fingerprint to Firebase:
  ```bash
  cd android
  ./gradlew signingReport
  ```
- Copy SHA-1 and add in Firebase Console → Project Settings → Your app

## Quick Commands Reference

```bash
# Check Flutter installation
flutter doctor

# Get dependencies
flutter pub get

# Run app
flutter run

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Clean project
flutter clean

# Check connected devices
flutter devices

# View logs
flutter logs
```

## System Requirements

### Minimum Requirements:
- **OS**: Windows 10 or later (64-bit)
- **Disk Space**: 2.5 GB (Flutter SDK + tools)
- **RAM**: 4 GB minimum, 8 GB recommended
- **Tools**: Git for Windows

### For Android Development:
- Android Studio or VS Code
- Android SDK
- Java JDK 11 or later

## Alternative: Use Online IDE

If you can't install Flutter locally, try:

1. **DartPad** (for testing Dart code)
   - https://dartpad.dev/

2. **FlutLab** (online Flutter IDE)
   - https://flutlab.io/

3. **Zapp** (Flutter playground)
   - https://zapp.run/

## Next Steps After Running

1. ✅ Test all features
2. ✅ Customize colors/theme
3. ✅ Add your own categories
4. ✅ Build release APK
5. ✅ Share with users

## Need Help?

- Flutter Docs: https://docs.flutter.dev/
- Firebase Docs: https://firebase.google.com/docs
- Check FIREBASE_SETUP.md for detailed Firebase instructions
- Check QUICKSTART.md for quick setup guide

---

## Summary

**To run this project, you need to:**

1. ✅ Install Flutter SDK
2. ✅ Run `flutter pub get`
3. ✅ Set up Firebase (CRITICAL!)
4. ✅ Add `google-services.json` to `android/app/`
5. ✅ Connect device or start emulator
6. ✅ Run `flutter run`

**Estimated Setup Time**: 30-45 minutes (first time)

Good luck! 🚀
