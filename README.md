

# Flutter iOS App Setup

## Requirements
- macOS with Xcode
- Flutter SDK installed (`flutter --version`)
- CocoaPods (`brew install cocoapods`)

## Steps to Run

```bash
git clone https://github.com/dineshkumar-770/unstudio-assesment-1.git
cd unstudio-assesment-1
flutter pub get
cd ios
pod install
cd ..
flutter run
```

## Before running the pod commands you have setup the iOS folder accordenly as per i sent to your.
## because some of the config files are not allowed to store at git. they used to be in the local.


## For physical iOS device, open ios/Runner.xcworkspace in Xcode and set your Apple developer team under Signing & Capabilities.