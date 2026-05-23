#!/bin/bash

echo "pwd: $(pwd)"

path_to_pubspec="../../pubspec.yaml"
current_version=$(awk '/^version:/ {print $2}' $path_to_pubspec)
current_version_without_build=$(echo "$current_version" | sed 's/\+.*//')
current_build_number=$(echo "$current_version" | awk -F '+' '{print $2}')
new_build_number=$((current_build_number + 1))
new_version="$current_version_without_build+$new_build_number"

echo "Setting pubspec.yaml version $current_version to $new_version"

sed -i "" "s/version: $current_version/version: $new_version/g" $path_to_pubspec