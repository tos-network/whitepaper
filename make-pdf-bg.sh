#!/bin/sh

# Compile Bulgarian PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Bulgarian PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_bg.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_bg.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_bg.aux tos_bg.log tos_bg.out tos_bg.toc tos_bg.fls tos_bg.fdb_latexmk tos_bg.synctex.gz

echo "PDF compilation completed: tos_bg.pdf"
exit 0

# Alternative: Online compilation (commented out)
# tar cjf tos_bg.tar.bz2 tos_bg.tex logo-transparent-128x128.png logo-transparent-400x400.png
# curl -o tos_bg.pdf --post301 --post302 --post303 -F file=@tos_bg.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos_bg.tex&command=pdflatex"
# rm tos_bg.tar.bz2
