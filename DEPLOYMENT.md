# Deployment Guide

## Prerequisites

1. Flutter SDK installed (3.x or higher)
2. Android Studio / Xcode installed
3. Firebase project configured (see FIREBASE_SETUP.md)

## Development Build

### Android Debug APK

```bash
flutter build apk --debug
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`

### iOS Debug Build

```bash
flutter build ios --debug
```

Then open Xcode and run on simulator/device.

## Production Build

### Android Release APK

1. **Generate Keystore** (first time only):

```bash
keytool -genkey -v -keystore ~/valuify-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias valuify
```

2. **Create `android/key.properties`**:

```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=valuify
storeFile=<path-to-your-keystore>/valuify-key.jks
```

3. **Update `android/app/build.gradle`**:

Add before `android` block:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Update `signingConfigs`:

```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

4. **Build Release APK**:

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS Release Build

1. Open Xcode: `open ios/Runner.xcworkspace`
2. Select "Any iOS Device" as target
3. Product → Archive
4. Follow App Store Connect upload process

## Testing the APK

### Install on Device

```bash
# Install debug APK
flutter install

# Or manually install
adb install build/app/outputs/flutter-apk/app-debug.apk
```

### Test Checklist

- [ ] Authentication (Email/Password)
- [ ] Authentication (Google Sign-In)
- [ ] Add transaction
- [ ] Edit transaction
- [ ] Delete transaction (swipe)
- [ ] Add category
- [ ] Set budget
- [ ] View charts
- [ ] Export CSV
- [ ] Export PDF
- [ ] Change theme
- [ ] Change currency
- [ ] Biometric lock (if available)
- [ ] Sign out

## Publishing

### Google Play Store

1. Create developer account
2. Create new app listing
3. Upload app bundle (`.aab` file)
4. Fill in store listing details
5. Set up pricing & distribution
6. Submit for review

### Apple App Store

1. Create App Store Connect account
2. Create new app
3. Upload build via Xcode
4. Fill in app information
5. Submit for review

## Continuous Integration (Optional)

### GitHub Actions Example

Create `.github/workflows/build.yml`:

```yaml
name: Build APK

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-java@v3
      with:
        distribution: 'zulu'
        java-version: '17'
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
    - run: flutter pub get
    - run: flutter build apk --debug
    - uses: actions/upload-artifact@v3
      with:
        name: debug-apk
        path: build/app/outputs/flutter-apk/app-debug.apk
```

## Version Management

Update version in `pubspec.yaml`:

```yaml
version: 1.0.0+1
```

Format: `major.minor.patch+buildNumber`

## Troubleshooting

### Build Errors

**"Gradle build failed"**
- Run `flutter clean`
- Delete `android/.gradle` folder
- Run `flutter pub get`
- Try again

**"Pod install failed" (iOS)**
- `cd ios && pod deintegrate`
- `pod install`
- Try again

### Firebase Issues

- Ensure `google-services.json` is in `android/app/`
- Ensure `GoogleService-Info.plist` is in `ios/Runner/`
- Check package name matches Firebase Console

## Performance Optimization

### Reduce APK Size

```bash
flutter build apk --release --split-per-abi
```

This creates separate APKs for different architectures:
- `app-armeabi-v7a-release.apk`
- `app-arm64-v8a-release.apk`
- `app-x86_64-release.apk`

### Enable Obfuscation

```bash
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
```

## Support

For deployment issues:
- Check Flutter documentation
- Review Firebase setup
- Verify signing configuration
- Test on multiple devices
