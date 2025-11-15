# Firebase Setup Guide for Valuify

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: **Valuify**
4. Follow the setup wizard

## Step 2: Enable Authentication

1. In Firebase Console, go to **Authentication**
2. Click "Get Started"
3. Enable **Email/Password** sign-in method
4. Enable **Google** sign-in method
   - Add your support email
   - Download the configuration files (next steps)

## Step 3: Set up Cloud Firestore

1. Go to **Firestore Database**
2. Click "Create database"
3. Choose **Start in production mode**
4. Select your preferred location
5. Click "Enable"

### Firestore Security Rules

Replace the default rules with:

```
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

## Step 4: Set up Firebase Storage

1. Go to **Storage**
2. Click "Get Started"
3. Use default security rules for now
4. Click "Done"

### Storage Security Rules

Replace with:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /receipts/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Step 5: Add Android App

1. In Project Overview, click the Android icon
2. Enter package name: `com.valuify.app`
3. Enter app nickname: `Valuify Android`
4. Click "Register app"
5. **Download `google-services.json`**
6. Place it in: `android/app/google-services.json`
7. Follow the SDK setup instructions (already done in build.gradle)

## Step 6: Add iOS App

1. In Project Overview, click the iOS icon
2. Enter bundle ID: `com.valuify.app`
3. Enter app nickname: `Valuify iOS`
4. Click "Register app"
5. **Download `GoogleService-Info.plist`**
6. Place it in: `ios/Runner/GoogleService-Info.plist`
7. Open Xcode and add the file to the Runner target

## Step 7: Install FlutterFire CLI (Optional but Recommended)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your Flutter project
flutterfire configure
```

This will automatically generate `firebase_options.dart` with your configuration.

## Step 8: Test the Setup

1. Run the app: `flutter run`
2. Try creating an account
3. Check Firebase Console to see if:
   - User appears in Authentication
   - User document created in Firestore
   - Default categories are created

## Troubleshooting

### Android Issues

- Make sure `google-services.json` is in `android/app/`
- Run `flutter clean` and `flutter pub get`
- Check that package name matches in:
  - `android/app/build.gradle` (applicationId)
  - Firebase Console
  - `google-services.json`

### iOS Issues

- Make sure `GoogleService-Info.plist` is added to Xcode project
- Check bundle identifier matches in:
  - Xcode project settings
  - Firebase Console
  - `GoogleService-Info.plist`

### Common Errors

**"Default FirebaseApp is not initialized"**
- Make sure `Firebase.initializeApp()` is called in `main()`
- Check that config files are in correct locations

**"Google Sign-In failed"**
- Enable Google Sign-In in Firebase Console
- For Android: Make sure SHA-1 fingerprint is added in Firebase Console
- For iOS: Make sure URL schemes are configured in Xcode

## Getting SHA-1 Fingerprint (Android)

For debug builds:
```bash
cd android
./gradlew signingReport
```

Copy the SHA-1 fingerprint and add it in Firebase Console:
Project Settings → Your apps → Android app → Add fingerprint

## Next Steps

After setup is complete:
1. Test authentication (email/password and Google)
2. Add a transaction and verify it appears in Firestore
3. Upload a receipt image and check Firebase Storage
4. Generate a report to test PDF/CSV export

## Support

For issues, check:
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- Project README.md
