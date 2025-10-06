#!/bin/sh

# Compile Japanese PDF using LaTeX.Online service
# (Local compilation requires many additional packages)

echo "Compiling Japanese PDF using LaTeX.Online service..."

tar cjf tos_jp.tar.bz2 tex_jp.tex logo-transparent-128x128.png logo-transparent-400x400.png
curl -o tos_jp.pdf --post301 --post302 --post303 -F file=@tos_jp.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tex_jp.tex&command=pdflatex"
rm tos_jp.tar.bz2

echo "Japanese PDF compilation completed: tos_jp.pdf"
exit 0
