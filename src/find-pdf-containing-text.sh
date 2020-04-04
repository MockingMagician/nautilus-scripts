#!/usr/bin/env bash

pwd=$(pwd)
tempFile=$(mktemp)
term=$(zenity --entry --text="Terme à rechercher")
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

gedit ${tempFile}

sh
