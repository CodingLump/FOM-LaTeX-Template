#!/usr/bin/env bash
#Run the Script from the folder you are in...
CURRENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
compile=""
biberarg=""

echo "Compiling in Language: $1"
if [ "$1" = "en" ]; then
  compile='pdflatex --shell-escape --jobname="thesis_englisch" "\def\FOMEN{}\input{$CURRENT_DIR/thesis_main.tex}"'
  biberarg="$CURRENT_DIR/thesis_englisch"
else
  compile='pdflatex --shell-escape "$CURRENT_DIR/thesis_main.tex"'
  biberarg="$CURRENT_DIR/thesis_main"
fi

eval "$compile"
RETVAL="$?"
if [[ "${RETVAL}" -ne 0 ]] ; then
    echo "First pdflatex run failed"
    exit ${RETVAL}
fi

biber "$biberarg"
RETVAL="$?"
if [[ "${RETVAL}" -ne 0 ]] ; then
    echo "biber run failed"
    exit ${RETVAL}
fi

eval "$compile"
RETVAL="$?"
if [[ "${RETVAL}" -ne 0 ]] ; then
    echo "Second pdflatex run failed"
    exit ${RETVAL}
fi

eval "$compile"
RETVAL="$?"
if [[ "${RETVAL}" -ne 0 ]] ; then
    echo "Third pdflatex run failed"
    exit ${RETVAL}
fi

rm *.bbl 2> /dev/null
rm *.blg 2> /dev/null
rm *.aux 2> /dev/null
rm *.bcf 2> /dev/null
rm *.ilg 2> /dev/null
rm *.lof 2> /dev/null
rm *.log 2> /dev/null
rm *.lot 2> /dev/null
rm *.nlo 2> /dev/null
rm *.nls* 2> /dev/null
rm *.out 2> /dev/null
rm *.toc 2> /dev/null
rm *.run.xml 2> /dev/null
rm *.lot 2> /dev/null

echo "PDF Compile: Success"

exit 0
