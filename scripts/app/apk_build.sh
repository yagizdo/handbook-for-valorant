# Usage: ./scripts/app/stage_apk.sh [prod|dev] [-s]
# -s: silent mode, no Finder open

ENV=stage
silent=false

echo "Building APK for $ENV environment"

if [ "$1" == "prod" ]; then
    ENV=prod
fi

if [ "$1" == "dev" ]; then
    ENV=dev
fi

if [ "$2" == "-s" ]; then
    silent=true
fi


flutter build apk --flavor $ENV --dart-define=ENV=$ENV

TIMESTAMP=$(date "+%Y-%m-%d-%H%M%S")

SOURCE_APK="./build/app/outputs/flutter-apk/app-${ENV}-release.apk"
RENAMED_APK="./build/app/outputs/flutter-apk/${TIMESTAMP}-app-${ENV}-release.apk"

cp "$SOURCE_APK" "$RENAMED_APK"

if [ -f "$SOURCE_APK" ]; then
    if [ "$silent" == false ]; then
        open -a Finder ./build/app/outputs/flutter-apk/
        open -a Terminal ./build/app/outputs/flutter-apk/
    fi
    echo "APK renamed to: ${TIMESTAMP}-app-${ENV}-release.apk"
else
    echo "$SOURCE_APK not found"
    exit 1
fi
