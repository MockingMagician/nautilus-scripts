#!/usr/bin/env bash

pwd=$(pwd)
tempFile=$(mktemp)
term=$(zenity --entry --text="Terme à rechercher")

(
echo "# Recherche de pdf dans le dossier: ${pwd}"
found=$(find "${pwd}" -name '*.pdf')
while IFS= read -r file
    do
    text=$(pdftotext "${file}" -)
    grep=$(echo "${text}" | grep -i --color "${term}")
    if [[ -z "${grep}" ]]
        then continue
    fi
    echo -e "Found matches in file: "$(realpath "${file}")"\n" >> ${tempFile}
    echo "Matches:" >> ${tempFile}
    while IFS= read -r match
    do
        echo "=> "${match} >> ${tempFile}
    done < <(printf '%s\n' "${grep}")
    echo -e "\n*** *** ***\n" >> ${tempFile}
done < <(printf '%s\n' "${found}")

echo "10" ; sleep 1
echo "# Mise à jour des journaux de mail" ; sleep 1
echo "20" ; sleep 1
echo "# Remise à zéro des paramètres" ; sleep 1
echo "50" ; sleep 1
echo "Cette ligne est ignorée" ; sleep 1
echo "75" ; sleep 1
echo "# Redémarrage du système" ; sleep 1
echo "100" ; sleep 1
) |
zenity --progress \
  --title="Mise à jour des journaux système" \
  --text="Analyse des journaux de mail..." \
  --percentage=0 \
  --auto-kill

if [[ "$?" = -1 ]]
    then
    zenity --error --text="Recherche annulée."
    return 0
fi

gedit ${tempFile}
