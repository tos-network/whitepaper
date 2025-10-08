#!/bin/sh

# Compile PDF using local MacTeX installation (Dutch version)

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Dutch PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_nl.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_nl.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_nl.aux tos_nl.log tos_nl.out tos_nl.toc tos_nl.fls tos_nl.fdb_latexmk tos_nl.synctex.gz

echo "PDF compilation completed: tos_nl.pdf"
exit 0

# Alternative: Online compilation (commented out)
# tar cjf tos_nl.tar.bz2 tos_nl.tex logo-transparent-128x128.png logo-transparent-400x400.png
# curl -o tos_nl.pdf --post301 --post302 --post303 -F file=@tos_nl.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos_nl.tex&command=pdflatex"
# rm tos_nl.tar.bz2
