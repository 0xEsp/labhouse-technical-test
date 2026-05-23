#!/bin/bash

path_to_pubspec="../../pubspec.yaml"
current_version=$(awk '/^version:/ {print $2}' $path_to_pubspec)
current_version_without_build=$(echo "$current_version" | sed 's/\+.*//')

echo -n ${current_version_without_build}