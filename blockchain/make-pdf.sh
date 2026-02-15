#!/bin/sh

# Compile PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling English PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos.aux tos.log tos.out tos.toc tos.fls tos.fdb_latexmk tos.synctex.gz

echo "PDF compilation completed: tos.pdf"
exit 0

# Alternative: Online compilation (commented out)
# tar cjf tos.tar.bz2 tos.tex logo-transparent-128x128.png logo-transparent-400x400.png
# curl -o tos.pdf --post301 --post302 --post303 -F file=@tos.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos.tex&command=pdflatex"
# rm tos.tar.bz2