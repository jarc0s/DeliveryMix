# DeliveryMix

DeliveryMix is an iOS SwiftUI project organized around local Swift Packages. The Xcode app target uses the `App` package as the application entry point, and feature code is split into independent packages under `DeliveryMix/Features`.

## Project Structure

```text
DeliveryMix/
  DeliveryMix.xcodeproj          Xcode project and app target
  DeliveryMix/                   App target assets and legacy wrapper views
  App/                           App composition and @main entry point
  Core/                          Shared domain, Firebase, networking, models
  UIComponents/                  Shared reusable UI components
  Features/
    Auth/
    Home/
    StoreDetail/
    Cart/
    Address/
    Checkout/
    OrderTracking/
    Profile/
scripts/
  run-simulator.sh               Build, install, and launch on Simulator
```

## Requirements

- macOS with Xcode installed
- iOS Simulator runtime installed
- Swift Package Manager support from Xcode
- Network access the first time dependencies are resolved

The project currently resolves Firebase through SwiftPM from:

```text
https://github.com/firebase/firebase-ios-sdk.git
```

## Opening The Project

Open the Xcode project:

```bash
open DeliveryMix/DeliveryMix.xcodeproj
```

Main scheme:

```text
DeliveryMix
```

## Run In Simulator

Use the provided script from the repository root:

```bash
scripts/run-simulator.sh
```

The script:

- builds the `DeliveryMix` scheme
- uses `iPhone 17 Pro` by default
- boots the simulator
- installs the app
- launches `com.jarcos.DeliveryMix`

Use a different simulator:

```bash
DEVICE_NAME="iPhone 17" scripts/run-simulator.sh
```

Use a simulator by ID:

```bash
DEVICE_ID="B80C2199-C7FF-4E61-AE27-7C3EFDC97DC3" scripts/run-simulator.sh
```

Optional shell alias:

```bash
alias deli-run="$PWD/scripts/run-simulator.sh"
```

To make that alias permanent, add it to your shell config:

```bash
echo 'alias deli-run="/Users/jarkos/Developer/SwiftUI/DeliveryMix/scripts/run-simulator.sh"' >> ~/.zshrc
source ~/.zshrc
```

## Useful Shell Commands

List available schemes:

```bash
xcodebuild -list -project DeliveryMix/DeliveryMix.xcodeproj
```

List available simulators:

```bash
xcrun simctl list devices available
```

Build for simulator without launching:

```bash
xcodebuild \
  -project DeliveryMix/DeliveryMix.xcodeproj \
  -scheme DeliveryMix \
  -configuration Debug \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  build
```

Build for generic iOS device without code signing:

```bash
xcodebuild \
  -project DeliveryMix/DeliveryMix.xcodeproj \
  -scheme DeliveryMix \
  -destination generic/platform=iOS \
  CODE_SIGNING_ALLOWED=NO \
  build
```

Validate the `App` package directly:

```bash
swift build \
  --package-path DeliveryMix/App \
  --triple arm64-apple-ios16.0 \
  --sdk "$(xcrun --sdk iphoneos --show-sdk-path)"
```

## Package Notes

The current dependency flow is:

```text
DeliveryMix target
  -> App
      -> Core
      -> UIComponents
      -> Features/*
```

Feature packages should generally depend only on:

- `Core`
- `UIComponents`

The `App` package should be responsible for app composition, navigation setup, dependency wiring, and global app configuration.

## Troubleshooting

If package resolution gets stuck in Xcode:

```bash
xcodebuild -resolvePackageDependencies -project DeliveryMix/DeliveryMix.xcodeproj
```

If the simulator script cannot find a device:

```bash
xcrun simctl list devices available
DEVICE_NAME="Exact Simulator Name" scripts/run-simulator.sh
```

If Xcode fails on device signing, set a Development Team in:

```text
Xcode -> DeliveryMix target -> Signing & Capabilities
```

If local build output gets too large, remove local DerivedData:

```bash
rm -rf .derivedData
```

The `.derivedData/` folder is ignored by git.
