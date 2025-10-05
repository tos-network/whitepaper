#!/bin/sh

# Compile pdf using LaTeX.Online service

tar cjf tos.tar.bz2 tos.tex logo-transparent-128x128.png logo-transparent-400x400.png
curl -o tos.pdf --post301 --post302 --post303 -F file=@tos.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos.tex&command=pdflatex"
rm tos.tar.bz2

exit 0

# Alternatively, pdf can be compiled locally

# Required Debian packages: texlive-latex-extra texlive-fonts-extra texlive-science
pdflatex tos.tex
# Second run for cross-references
pdflatex tos.tex