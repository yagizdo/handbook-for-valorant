#!/bin/bash

set -euo pipefail

echo "- Checking Android Build Number -"
LATEST_BUILD_VERSION_ANDROID=$(firebase-app-distribution get-latest-build-version -p "$FIREBASE_PROJECT_ID" -a "$FIREBASE_ANDROID_APP_ID" || echo 0)
echo "Latest Android Build Number: $LATEST_BUILD_VERSION_ANDROID"

if ! [[ "$LATEST_BUILD_VERSION_ANDROID" =~ ^[0-9]+$ ]]; then
  echo "Warning: Android build number is not a valid number. Defaulting to 0."
  LATEST_BUILD_VERSION_ANDROID=0
fi

echo "- Checking iOS Build Number (Firebase) -"
LATEST_BUILD_VERSION_IOS=$(firebase-app-distribution get-latest-build-version -p "$FIREBASE_PROJECT_ID" -a "$FIREBASE_IOS_APP_ID" || echo 0)
echo "Latest iOS Build Number: $LATEST_BUILD_VERSION_IOS"

# Fetch iOS build number from App Store Connect
echo "- Checking iOS Build Number (App Store Connect) -"
LATEST_BUILD_VERSION_IOS=$(app-store-connect get-latest-testflight-build-number "$APP_APPLE_ID")
echo "iOS version number found: $LATEST_BUILD_VERSION_IOS"

if ! [[ "$LATEST_BUILD_VERSION_IOS" =~ ^[0-9]+$ ]]; then
  echo "Warning: iOS build number is not a valid number. Defaulting to 0."
  LATEST_BUILD_VERSION_IOS=0
fi

# Safety check: if both platforms returned invalid values, stop the pipeline
if [[ "$LATEST_BUILD_VERSION_ANDROID" -eq 0 && "$LATEST_BUILD_VERSION_IOS" -eq 0 ]]; then
  echo "Error: Both Android (=$LATEST_BUILD_VERSION_ANDROID) and iOS (=$LATEST_BUILD_VERSION_IOS) build numbers resolved to 0."
  echo "  Possible causes: no prior builds in Firebase App Distribution / App Store Connect,"
  echo "  or invalid FIREBASE_PROJECT_ID / FIREBASE_*_APP_ID / APP_APPLE_ID env vars."
  exit 1
fi

# Determine the highest build number across both platforms
HIGHEST_BUILD_NUMBER=$(( LATEST_BUILD_VERSION_ANDROID > LATEST_BUILD_VERSION_IOS ? LATEST_BUILD_VERSION_ANDROID : LATEST_BUILD_VERSION_IOS ))

# Increment to ensure the new build number is +1 of the highest
NEW_BUILD_NUMBER=$((HIGHEST_BUILD_NUMBER + 1))

echo "Target build number for both platforms: $NEW_BUILD_NUMBER"

# Store in environment variable for Codemagic
echo "UPDATED_BUILD_NUMBER=$NEW_BUILD_NUMBER" >> "$CM_ENV"
