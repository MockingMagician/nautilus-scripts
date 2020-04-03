#!/usr/bin/env bash

export TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata
echo ${TESSDATA_PREFIX}

filePath=$1
filePath=$(realpath "${filePath}")

basename=$(basename "${filePath}")
basename="${basename%.*}"

dir=$(dirname "${filePath}")
dir=$(realpath "${dir}")

wdir=$(mktemp -d)
mkdir "${wdir}/png"
mkdir "${wdir}/list"
mkdir "${wdir}/export"

lang=$2
rotate=$3

echo "FILE_PATH : "${filePath}
echo "BASENAME : "${basename}
echo "DIR : "${dir}
echo "WDIR : "${wdir}
echo "LANG : "${lang}


# 1. Generate PNG from pdf
if [[ ${rotate} == 1 ]]
then
    echo "Generate PNG (rotate)"
    gs -q -dSAFER -dBATCH -dNOPAUSE -r300 -sDEVICE=pnggray -dTextAlphaBits=4 \
       -sOutputFile="${wdir}/png/img_%0.4d.png" \
       -c "<</Orientation 3>> setpagedevice" \
       -f "${filePath}"
else
    echo "Generate PNG"
    gs -q -dSAFER -dBATCH -dNOPAUSE -r300 -sDEVICE=pnggray -dTextAlphaBits=4 \
       -sOutputFile="${wdir}/png/img_%0.4d.png" \
       -f "${filePath}"
fi


# 2. Generate list of these PNG
ls "${wdir}/png" > "${wdir}/list/list.txt"


# 3. Go tesseract ! Go!
cd "${wdir}/png" && tesseract "${wdir}/list/list.txt" "${wdir}/export/${basename}" pdf -l "${lang}"


# 4. Reduce pdf size, export and clean up
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook  -dNOPAUSE  -dBATCH \
   -sOutputFile="${dir}/${basename}_ocrized.pdf" \
   -f "${wdir}/export/${basename}.pdf"

rm -Rf "${wdir}"
