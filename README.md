

# Flutter iOS App Setup

## Requirements
- macOS with Xcode
- Flutter SDK installed (`flutter --version`)
- CocoaPods (`brew install cocoapods`)

## Steps to Run

```bash
git clone <your-repo-url>
cd <project-folder>
flutter pub get
cd ios
pod install
cd ..
flutter run
```

## For physical iOS device, open ios/Runner.xcworkspace in Xcode and set your Apple developer team under Signing & Capabilities.