# Valuify - Quick Start Guide

## 🚀 5-Minute Setup

### Step 1: Install Flutter (if not installed)

**Windows:**
```bash
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
# Extract and add to PATH
```

**macOS:**
```bash
brew install flutter
```

**Linux:**
```bash
# Download from https://flutter.dev/docs/get-started/install/linux
```

Verify installation:
```bash
flutter doctor
```

### Step 2: Clone Repository

```bash
git clone https://github.com/skulllord/Valuify.git
cd Valuify
```

### Step 3: Install Dependencies

```bash
flutter pub get
```

### Step 4: Firebase Setup (Required)

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com/
   - Click "Add project"
   - Name it "Valuify"

2. **Enable Services**
   - Authentication → Enable Email/Password + Google
   - Firestore Database → Create database (production mode)
   - Storage → Get started

3. **Add Android App**
   - Package name: `com.valuify.app`
   - Download `google-services.json`
   - Place in `android/app/google-services.json`

4. **Add iOS App** (if building for iOS)
   - Bundle ID: `com.valuify.app`
   - Download `GoogleService-Info.plist`
   - Place in `ios/Runner/GoogleService-Info.plist`

### Step 5: Run the App

```bash
# Connect device or start emulator
flutter devices

# Run app
flutter run
```

## 🎯 First Time Use

1. **Sign Up**
   - Open app
   - Click "Sign Up"
   - Enter email, password, name
   - Or use "Continue with Google"

2. **Add First Transaction**
   - Tap the "+" button
   - Select Income or Expense
   - Choose category
   - Enter amount
   - Save

3. **Set Budget**
   - Go to Budgets tab
   - Tap on a category
   - Enter budget amount
   - Save

4. **View Dashboard**
   - See your balance
   - Check charts
   - View recent transactions

## 🔧 Common Commands

```bash
# Run app
flutter run

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Clean build
flutter clean

# Get dependencies
flutter pub get

# Check for issues
flutter analyze

# Format code
flutter format .

# Run tests
flutter test
```

## 📱 Testing on Device

### Android
```bash
# Enable USB debugging on phone
# Connect via USB
# Run:
flutter run
```

### iOS
```bash
# Connect iPhone
# Trust computer
# Run:
flutter run
```

## 🐛 Troubleshooting

### "Flutter not found"
```bash
# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### "Firebase not initialized"
- Check `google-services.json` is in `android/app/`
- Check `GoogleService-Info.plist` is in `ios/Runner/`
- Run `flutter clean` and `flutter pub get`

### "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### "Pod install failed" (iOS)
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter run
```

## 📚 Next Steps

1. Read `FEATURES.md` for complete feature list
2. Check `FIREBASE_SETUP.md` for detailed Firebase config
3. See `DEPLOYMENT.md` for production builds
4. Review `CONTRIBUTING.md` to contribute

## 🎨 Customization

### Change App Name
Edit `pubspec.yaml`:
```yaml
name: your_app_name
```

### Change Package Name
1. Update `android/app/build.gradle`
2. Update `AndroidManifest.xml`
3. Update Firebase console
4. Re-download `google-services.json`

### Change Colors
Edit `lib/utils/colors.dart`

### Add Features
1. Create new screen in `lib/screens/`
2. Add provider in `lib/providers/`
3. Update navigation in `lib/main.dart`

## 💡 Tips

- Use hot reload: Press `r` in terminal while app is running
- Use hot restart: Press `R` in terminal
- Check logs: `flutter logs`
- Debug in VS Code or Android Studio for better experience

## 🆘 Get Help

- Documentation: Check all `.md` files in project
- Issues: https://github.com/skulllord/Valuify/issues
- Flutter Docs: https://flutter.dev/docs
- Firebase Docs: https://firebase.google.com/docs

## ✅ Checklist

Before pushing to production:
- [ ] Firebase configured correctly
- [ ] All features tested
- [ ] App runs on Android
- [ ] App runs on iOS (if applicable)
- [ ] No console errors
- [ ] Proper error handling
- [ ] Security rules set up
- [ ] App icon added
- [ ] Splash screen configured

## 🎉 You're Ready!

Your Valuify app is now set up and running. Start tracking your finances!

---

**Need more help?** Check the other documentation files or create an issue on GitHub.
