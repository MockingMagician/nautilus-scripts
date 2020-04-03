#!/usr/bin/env bash

dir=$(dirname "${0}")
dir=$(realpath "${dir}")

for file in ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}
   do
     sh ${dir}/.component/ocrize-pdf.sh ${file}
done
