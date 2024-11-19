#!/bin/zsh --no-rcs
set -euo pipefail

fwLink="2093504"
downloadURL="https://go.microsoft.com/fwlink/?linkid=$fwLink"

# Fetch the HTTP headers and extract the location URL
locationURL=$(curl -fsIL "$downloadURL" | grep -i location: | awk '{print $2}' | tr -d '\r')

# Check if locationURL is empty
if [[ -z "$locationURL" ]]; then
  echo "Failed to retrieve the location URL."
  exit 1
fi

# Extract the version number from the location URL
appNewVersion=$(echo "$locationURL" | grep -o "/MicrosoftEdge.*pkg" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g')

# Check if appNewVersion is empty
if [[ -z "$appNewVersion" ]]; then
  echo "Failed to extract the version number."
  exit 1
fi

echo "New version: $appNewVersion"
