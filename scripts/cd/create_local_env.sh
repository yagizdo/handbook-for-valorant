#!/bin/bash
set -e
set -x

if [[ -z $IS_DEVELOPER_MODE_ENABLED ]]; then
    echo "IS_DEVELOPER_MODE_ENABLED is not set".
    exit 1
fi

if [[ -z $BASE_URL ]]; then
    echo "BASE_RUL is not set".
    exit 1
fi

if [[ -z $MAPBOX_ACCESS_TOKEN ]]; then
    echo "MAPBOX_ACCESS_TOKEN is not set".
    exit 1
fi

if [[ -z $X_CLIENT_ID ]]; then
    echo "X_CLIENT_ID is not set".
    exit 1
fi

mkdir -p module/gen/assets/env
cd module/gen/assets/env || exit 1
touch .env

cat <<EOF >> .env.dev
IS_DEVELOPER_MODE_ENABLED=$IS_DEVELOPER_MODE_ENABLED
BASE_URL=$BASE_URL
MAPBOX_ACCESS_TOKEN=$MAPBOX_ACCESS_TOKEN
X_CLIENT_ID=$X_CLIENT_ID
EOF


cat <<EOF >> .env.prod
IS_DEVELOPER_MODE_ENABLED=$IS_DEVELOPER_MODE_ENABLED
BASE_URL=$BASE_URL
MAPBOX_ACCESS_TOKEN=$MAPBOX_ACCESS_TOKEN
X_CLIENT_ID=$X_CLIENT_ID
EOF


cat <<EOF >> .env.stage
IS_DEVELOPER_MODE_ENABLED=$IS_DEVELOPER_MODE_ENABLED
BASE_URL=$BASE_URL
MAPBOX_ACCESS_TOKEN=$MAPBOX_ACCESS_TOKEN
X_CLIENT_ID=$X_CLIENT_ID
EOF