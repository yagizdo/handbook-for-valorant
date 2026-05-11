#!/bin/bash
set -euo pipefail

# # Fetch Android build number
# LATEST_BUILD_VERSION_ANDROID=$(google-play get-latest-build-number --package-name "$ANDROID_PACKAGE_NAME" -t=internal)
# echo "Android version number found: $LATEST_BUILD_VERSION_ANDROID"

# Fetch iOS build number
LATEST_BUILD_VERSION_IOS=$(app-store-connect get-latest-testflight-build-number "$APP_APPLE_ID")
echo "iOS version number found: $LATEST_BUILD_VERSION_IOS"

# # Fallback to 0 if build numbers are empty or invalid
# if ! [[ "$LATEST_BUILD_VERSION_ANDROID" =~ ^[0-9]+$ ]]; then
#   echo "Warning: Android build number is not a valid number. Defaulting to 0."
#   LATEST_BUILD_VERSION_ANDROID=0
# fi

if ! [[ "$LATEST_BUILD_VERSION_IOS" =~ ^[0-9]+$ ]]; then
  echo "Warning: iOS build number is not a valid number. Defaulting to 0."
  LATEST_BUILD_VERSION_IOS=0
fi

# # Determine the highest build number (Android vs iOS comparison)
# if [ "$LATEST_BUILD_VERSION_ANDROID" -gt "$LATEST_BUILD_VERSION_IOS" ]; then
#   HIGHEST_BUILD_NUMBER=$LATEST_BUILD_VERSION_ANDROID
# else
#   HIGHEST_BUILD_NUMBER=$LATEST_BUILD_VERSION_IOS
# fi

# Increment build number by 1
NEW_BUILD_NUMBER=$((LATEST_BUILD_VERSION_IOS + 1))

echo "Setting iOS build number to: $NEW_BUILD_NUMBER"

# Export to CI/CD env file
# echo "ANDROID_BUILD_NUMBER=$NEW_BUILD_NUMBER" >> "$CM_ENV"
echo "IOS_BUILD_NUMBER=$NEW_BUILD_NUMBER" >> "$CM_ENV"