#!/usr/bin/env bash

pwd=$(pwd)

term=$(zenity --entry --text="Terme à rechercher")

#find ${pwd} -name '*.pdf' -exec sh -c 'pdftotext "{}" - | grep -i --with-filename --label="{}" --color "${term}"' \;


tempFile=$(mktemp)

for found in $(find ${pwd} -name '*.pdf')
    do
        pdfText=$(pdftotext ${found})
done

gedit ${tempFile}
