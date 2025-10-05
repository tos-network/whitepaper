#!/bin/sh

# Compile Chinese PDF using LaTeX.Online service

tar cjf tos_cn.tar.bz2 tos_cn.tex logo-transparent-128x128.png logo-transparent-400x400.png
curl -o tos_cn.pdf --post301 --post302 --post303 -F file=@tos_cn.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos_cn.tex&command=xelatex"
rm tos_cn.tar.bz2

exit 0

# Alternatively, PDF can be compiled locally

# Required Debian packages: texlive-latex-extra texlive-fonts-extra texlive-science texlive-lang-chinese
# xelatex tos_cn.tex
# Second run for cross-references
# xelatex tos_cn.tex
