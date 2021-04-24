#!/usr/bin/env bash

# Get script directory
scriptDir=$(dirname "${0}")
scriptDir=$(realpath "${scriptDir}")

# Imports
# shellcheck source=${scriptDir}/.component/helper/getLineInVar.sh
. ${scriptDir}/.component/helper/getLineInVar.sh
# shellcheck source=${scriptDir}/.component/helper/getPercent.sh
. ${scriptDir}/.component/helper/getPercent.sh

pwd=$(pwd)
tempFile=$(mktemp)
term=$(zenity --entry --text="Terme à rechercher")

IFS=$'\n'
i=0

(
echo "# Recherche de pdf dans le dossier: ${pwd}"
found=$(find "${pwd}" -name '*.pdf')

# Calculate number of file are selected
nbOfFile=$(getLineInVar "${found}")

for file in ${found}
    do
    echo "# Recherche de correspondance dans le fichier: $(basename -- ${file})"
    text=$(pdftotext "${file}" -)
    grep=$(echo "${text}" | grep -i --color "${term}")
    if [[ -z "${grep}" ]]
        then
        i=$((${i} + 1))
        percent=$(getPercent ${i} ${nbOfFile})
        echo "${percent}"
        continue
    fi
    echo -e "Found matches in file: \"$(realpath "${file}")\"\n" >> "${tempFile}"
    echo "Matches:" >> "${tempFile}"
    for match in ${grep}
    do
        echo "=> ${match}" >> "${tempFile}"
    done
    echo -e "\n*** *** ***\n" >> "${tempFile}"

    i=$((${i} + 1))
    percent=$(getPercent "${i} ${nbOfFile}")
    echo "${percent}"
done
) |
zenity --progress \
  --title="Recherche de terme dans PDF" \
  --percentage=0 \
  --auto-kill \
  --auto-close

if [[ "$?" = -1 ]]
    then
    zenity --error --text="Recherche annulée."
    return 0
fi

gedit "${tempFile}"
