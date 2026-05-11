#!/bin/bash

dart run easy_localization:generate  -O modules/gen/lib/src/language -f keys -o locale_keys.g.dart --source-dir modules/gen/assets/translations
