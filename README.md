# ksa_real_estates

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
this app have flavors
normal
shabakat
asia

we added them to change the applicationId and appName and app icon
to add a new flavor add it in android/app/build.gradle  
under android {

flavorDimensions "default"
productFlavors {
//here add the new flavor
newFlavor {
dimension "default"
applicationId " here add the new package name  "
manifestPlaceholders = [appName: "here add the new app name"]
}

and in android/app/src/main/AndroidManifest.xml change the android:name="${applicationName}" to android:name="${appName}"

and for the app icon to be changed by flavor
you need to add new folder with the name of the new flavor in android/app/src/
like this
android/app/src/newFlavor/res/
and add a new file in the main application folder
flutter_launcher_icons-newFlavor.yaml
that contains

flutter_launcher_icons:
android: true
ios: true
image_path: " here put the path for the new flavor app icon"

then run this command after flutter clean flutter pub get
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons

//
build apk:
flutter build apk --release --flavor normal -t lib/main.dart
flutter build apk --release --flavor asia -t lib/main.dart
flutter build apk --release --flavor shabakat -t lib/main.dart
//
run app:
flutter run --release --flavor normal -t lib/main.dart
flutter run --release --flavor asia -t lib/main.dart
flutter run --release --flavor shabakat -t lib/main.dart


------------------------ btw ----------------------------
to set your flavor in android studio go to main edit configuration and set your base flavor
min is normal