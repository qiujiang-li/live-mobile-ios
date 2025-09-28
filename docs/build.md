# Build prerequisites

This repository hosts native client scaffolding for iOS and Android under the `clients/` directory. Building the debug variants relies on the following tooling:

## iOS (`clients/ios/App`)

* Xcode 15.2 or newer with the iOS 17 SDK.
* CocoaPods is **not** required.
* The project is configured for unsigned debug builds (code signing is disabled in Debug). To run on a device you will need to add your signing team identifier inside Xcode.

### Build

```bash
cd clients/ios/App
xcodebuild \
  -scheme App \
  -configuration Debug \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath build
```

The resulting `.app` bundle can be found under `build/Build/Products/Debug-iphonesimulator/`.

## Android (`clients/android`)

* Java 17 JDK.
* Gradle 8.2.2 (the provided `gradlew` script will use a locally installed Gradle if the wrapper JAR is unavailable).
* Android SDK Platform 34 and build tools 34.0.0 or newer.

### Build

```bash
cd clients/android
./gradlew :app:assembleDebug
```

The generated APK is located at `app/build/outputs/apk/debug/app-debug.apk`.
