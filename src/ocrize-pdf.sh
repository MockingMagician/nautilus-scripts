#!/usr/bin/env bash

scriptDir=$(dirname "${0}")
scriptDir=$(realpath "${scriptDir}")

for file in ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}
   do
     sh ${scriptDir}/.component/ocrize-pdf.sh ${file}
done
