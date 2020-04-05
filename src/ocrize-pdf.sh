#!/usr/bin/env bash

# Get script directory
scriptDir=$(dirname "${0}")
scriptDir=$(realpath "${scriptDir}")

# Imports
. ${scriptDir}/.component/helper/getLineInVar.sh
. ${scriptDir}/.component/helper/getPercent.sh

# Calculate number of file are selected
nbOfFile=$(getLineInVar "${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}")

IFS=$'\n'
i=0

(
for file in ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}
   do
    echo "# Ocrizing $(basename -- ${file})"
    ${scriptDir}/.component/ocrize-pdf.sh ${file}
    i=$((${i} + 1))
    percent=$(getPercent ${i} ${nbOfFile})
    echo "${percent}"
done
) |
zenity --progress \
  --title="Ocrizing PDF" \
  --text="Traitement ..." \
  --percentage=0 \
  --auto-kill \
  --auto-close

if [[ "$?" = -1 ]]
    then
    zenity --error --text="Ocrizing annulé"
    return 0
fi
