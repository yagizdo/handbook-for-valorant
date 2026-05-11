#!/bin/bash

bash scripts/app/lang.sh

#rm -rf modules/gen/lib/src/environment/env.g.dart
#echo "Removed env.g.dart"
#echo "Building..."
#if [ "$1" = "clean" ]
#then
#    dart run build_runner clean
#    echo "Cleaned"
#fi
cd modules/core || exit
dart run build_runner build --delete-conflicting-outputs
echo "Core module build done"
cd ../..

cd modules/theme_module || exit
dart run build_runner build --delete-conflicting-outputs
echo "Theme module build done"
cd ../..

dart run build_runner build --delete-conflicting-outputs
echo "App level build done"

cd modules/gen || exit
if [ "$1" = "clean" ]
then
    dart run build_runner clean
    echo "Cleaned"
fi
dart run build_runner build  --delete-conflicting-outputs
echo "Gen level build done"
cd ../..
flutter pub get
echo "Build.sh done"
