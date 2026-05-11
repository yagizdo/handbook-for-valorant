#!/bin/sh
base_ref=$CM_BRANCH
version_number=${base_ref#*/}
echo "$version_number"
echo "BUILD_NAME=$version_number" >> "$CM_ENV"
