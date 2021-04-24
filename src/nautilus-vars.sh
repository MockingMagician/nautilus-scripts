#!/usr/bin/env bash

tempFile=$(mktemp)

echo "\$0:" >> "${tempFile}"
echo "${0}" >> "${tempFile}"

echo "" >> "${tempFile}"

scriptDirectory=$(dirname "${0}")
scriptDirectory=$(realpath "${scriptDirectory}")
echo "scriptDirectory:" >> "${tempFile}"
echo "${scriptDirectory}" >> "${tempFile}"

echo "" >> "${tempFile}"

echo "pwd:" >> "${tempFile}"
pwd=$(pwd)
echo "${pwd}" >> "${tempFile}"

echo "" >> "${tempFile}"

IFS=$'\n'

echo "NAUTILUS_SCRIPT_SELECTED_FILE_PATHS:" >> "${tempFile}"
for file in ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}
   do
     echo "${file}" >> "${tempFile}"
done

echo "" >> "${tempFile}"

echo "NAUTILUS_SCRIPT_SELECTED_URIS:" >> "${tempFile}"
for file in ${NAUTILUS_SCRIPT_SELECTED_URIS}
   do
     echo "${file}" >> "${tempFile}"
done

{
  echo ""
  echo "NAUTILUS_SCRIPT_CURRENT_URI:"
  echo "${NAUTILUS_SCRIPT_CURRENT_URI}"
  echo ""
  echo "NAUTILUS_SCRIPT_WINDOW_GEOMETRY:"
  echo "${NAUTILUS_SCRIPT_WINDOW_GEOMETRY}"
} >> "${tempFile}"

gedit "${tempFile}"
