#!/usr/bin/env bash

pwd=$(pwd)
tempFile=$(mktemp)
term=$(zenity --entry --text="Terme à rechercher")

for found in $(find ${pwd} -name '*.pdf')
    do
    text=$(pdftotext ${found} -)
    grep=$(echo "${text}" | grep -i --color ${term})
    if [[ -z "${grep}" ]]
        then continue
    fi
    echo -e "Found matches in file: $(realpath ${found})\n" >> ${tempFile}
    echo "Matches:" >> ${tempFile}
    echo ${grep} >> ${tempFile}
    echo -e "\n*** *** ***\n" >> ${tempFile}
done

gedit ${tempFile}
