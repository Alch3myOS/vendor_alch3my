#!/bin/bash
#
# Copyright (C) 2019-2026 crDroid Android Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
#

# $1 = TARGET_DEVICE
# $2 = PRODUCT_OUT
# $3 = FILE_NAME

DEVICE="$1"
PRODUCT_OUT="$2"
FILENAME="$3"

# Detect build variant
if [[ "$FILENAME" == *"vanilla"* ]]; then
    BUILD_VARIANT="vanilla"
else
    BUILD_VARIANT="gapps"
fi

# Set OTA json location
if [[ "$BUILD_VARIANT" == "vanilla" ]]; then
    existingOTAjson="./vendor/OTA/builds/vanilla/${DEVICE}.json"
    DOWNLOAD_URL="https://sourceforge.net/projects/ghosuto/files/${DEVICE}/vanilla/${FILENAME}/download"
else
    existingOTAjson="./vendor/OTA/builds/${DEVICE}.json"
    DOWNLOAD_URL="https://sourceforge.net/projects/ghosuto/files/${DEVICE}/${FILENAME}/download"
fi

output="${PRODUCT_OUT}/${DEVICE}.json"

# Cleanup old file
if [ -f "$output" ]; then
    rm "$output"
fi

echo "Generating JSON file data for OTA support..."

# Helper function to extract field from JSON
extract_field() {
    grep "\"$1\":" "$existingOTAjson" \
        | sed -n "s/.*\"$1\": *\"\([^\"]*\)\".*/\1/p" \
        | xargs
}

# Load existing OTA metadata if present
if [ -f "$existingOTAjson" ]; then
    MAINTAINER=$(extract_field "maintainer")
    DEVICE_NAME=$(extract_field "device")
    BUILDTYPE=$(extract_field "buildtype")
    GAPPS=$(extract_field "gapps")
    PAYPAL=$(extract_field "paypal")
    TELEGRAM=$(extract_field "telegram")
fi

# Extract version from filename
VERSION=$(echo "$FILENAME" | cut -d'-' -f2 | sed 's/v//')

# Build information
BUILDPROP="$PRODUCT_OUT/system/build.prop"
TIMESTAMP=$(grep "ro.system.build.date.utc" "$BUILDPROP" | cut -d'=' -f2)

MD5=$(md5sum "$PRODUCT_OUT/$FILENAME" | cut -d' ' -f1)
SHA256=$(sha256sum "$PRODUCT_OUT/$FILENAME" | cut -d' ' -f1)
SIZE=$(stat -c "%s" "$PRODUCT_OUT/$FILENAME")

# Generate JSON
cat <<EOF >"$output"
{
  "response": [
    {
      "maintainer": "${MAINTAINER:-}",
      "oem": "${OEM:-}",
      "device": "${DEVICE_NAME:-$DEVICE}",
      "filename": "$FILENAME",
      "download": "$DOWNLOAD_URL",
      "timestamp": $TIMESTAMP,
      "md5": "$MD5",
      "sha256": "$SHA256",
      "size": $SIZE,
      "version": "$VERSION",
      "buildtype": "${BUILDTYPE:-}",
      "gapps": "${GAPPS:-}",
      "paypal": "${PAYPAL:-}",
      "telegram": "${TELEGRAM:-}",
    }
  ]
}
EOF

echo "JSON file generation completed"
