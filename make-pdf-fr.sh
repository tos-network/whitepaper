#!/bin/sh

# Compile French PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling French PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_fr.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_fr.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_fr.aux tos_fr.log tos_fr.out tos_fr.toc tos_fr.fls tos_fr.fdb_latexmk tos_fr.synctex.gz

echo "French PDF compilation completed: tos_fr.pdf"
exit 0
