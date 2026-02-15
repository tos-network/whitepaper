#!/bin/sh

# Compile Korean PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Korean PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_ko.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_ko.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_ko.aux tos_ko.log tos_ko.out tos_ko.toc tos_ko.fls tos_ko.fdb_latexmk tos_ko.synctex.gz

echo "PDF compilation completed: tos_ko.pdf"
exit 0

# Alternative: Online compilation (commented out)
# tar cjf tos_ko.tar.bz2 tos_ko.tex logo-transparent-128x128.png logo-transparent-400x400.png
# curl -o tos_ko.pdf --post301 --post302 --post303 -F file=@tos_ko.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos_ko.tex&command=pdflatex"
# rm tos_ko.tar.bz2
