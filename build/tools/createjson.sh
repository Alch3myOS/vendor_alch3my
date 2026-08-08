#!/bin/bash
#
# Copyright (C) 2019-2025 crDroid Android Project
# Copyright (C) 2026 Alch3myOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
#

# $1 = TARGET_DEVICE
# $2 = PRODUCT_OUT
# $3 = FILE_NAME

DEVICE="$1"
PRODUCT_OUT="$2"
FILENAME="$3"

BUILD_VARIANT="gapps"
existingOTAjson="./vendor/OTA/builds/${DEVICE}.json"
DOWNLOAD_URL="https://sourceforge.net/projects/libra420t-alch3my/files/${DEVICE}/1.0/${FILENAME}/download"

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
      "maintainer": "${ALCH3MY_MAINTAINER:-}",
      "device": "${DEVICE_NAME:-$DEVICE}",
      "filename": "$FILENAME",
      "download": "$DOWNLOAD_URL",
      "timestamp": $TIMESTAMP,
      "md5": "$MD5",
      "sha256": "$SHA256",
      "size": $SIZE,
      "version": "$ALCH3MY_VERSION",
      "buildtype": "$ALCH3MY_BUILD_TYPE",
      "paypal": "${PAYPAL:-}",
      "telegram": "${TELEGRAM:-}",
    }
  ]
}
EOF

echo "JSON file generation completed"
