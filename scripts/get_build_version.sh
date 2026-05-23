#!/bin/bash

path_to_pubspec="../../pubspec.yaml"
current_version=$(awk '/^version:/ {print $2}' $path_to_pubspec)
current_build_number=$(echo "$current_version" | awk -F '+' '{print $2}')

echo -n ${current_build_number}