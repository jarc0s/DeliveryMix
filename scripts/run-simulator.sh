#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT="${PROJECT:-$ROOT_DIR/DeliveryMix/DeliveryMix.xcodeproj}"
SCHEME="${SCHEME:-DeliveryMix}"
CONFIGURATION="${CONFIGURATION:-Debug}"
DEVICE_NAME="${DEVICE_NAME:-iPhone 17 Pro}"
BUNDLE_ID="${BUNDLE_ID:-com.jarcos.DeliveryMix}"
APP_NAME="${APP_NAME:-DeliveryMix}"
DERIVED_DATA="${DERIVED_DATA:-$ROOT_DIR/.derivedData}"

find_device_id() {
  xcrun simctl list devices available | awk -v name="$DEVICE_NAME" '
    $0 ~ name {
      if (match($0, /\([0-9A-F-]{36}\)/)) {
        print substr($0, RSTART + 1, RLENGTH - 2)
        exit
      }
    }
  '
}

DEVICE_ID="${DEVICE_ID:-$(find_device_id)}"

if [[ -z "$DEVICE_ID" ]]; then
  echo "No simulator found for DEVICE_NAME=\"$DEVICE_NAME\"."
  echo "Run: xcrun simctl list devices available"
  exit 1
fi

APP_PATH="$DERIVED_DATA/Build/Products/$CONFIGURATION-iphonesimulator/$APP_NAME.app"

echo "Building $SCHEME for $DEVICE_NAME ($DEVICE_ID)..."
xcodebuild \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration "$CONFIGURATION" \
  -destination "id=$DEVICE_ID" \
  -derivedDataPath "$DERIVED_DATA" \
  build

if [[ ! -d "$APP_PATH" ]]; then
  echo "Build succeeded, but app was not found at:"
  echo "$APP_PATH"
  exit 1
fi

echo "Booting simulator..."
xcrun simctl boot "$DEVICE_ID" 2>/dev/null || true
xcrun simctl bootstatus "$DEVICE_ID" -b

if command -v open >/dev/null 2>&1; then
  open -a Simulator
fi

echo "Installing $APP_PATH..."
xcrun simctl install "$DEVICE_ID" "$APP_PATH"

echo "Launching $BUNDLE_ID..."
xcrun simctl launch "$DEVICE_ID" "$BUNDLE_ID"
