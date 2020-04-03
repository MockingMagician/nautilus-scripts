#!/usr/bin/env bash

tempFile=$(mktemp)

echo "NAUTILUS_SCRIPT_SELECTED_FILE_PATHS:\n" > ${tempFile}
echo ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS} > ${tempFile}

echo "\n" > ${tempFile}

echo "NAUTILUS_SCRIPT_SELECTED_URIS:\n" > ${tempFile}
echo ${NAUTILUS_SCRIPT_SELECTED_URIS} > ${tempFile}

echo "\n" > ${tempFile}

echo "NAUTILUS_SCRIPT_CURRENT_URI:\n" > ${tempFile}
echo ${NAUTILUS_SCRIPT_CURRENT_URI} > ${tempFile}

echo "\n" > ${tempFile}

echo "NAUTILUS_SCRIPT_WINDOW_GEOMETRY:\n" > ${tempFile}
echo ${NAUTILUS_SCRIPT_WINDOW_GEOMETRY} > ${tempFile}

gedit ${tempFile}
