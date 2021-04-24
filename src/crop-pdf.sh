#!/usr/bin/env bash

IFS=$'\n'

for file in ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}
   do
    pdf-crop-margins -v -p 0 -a -6 ${file}
done
