#!/bin/sh

# Compile Ukrainian PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Ukrainian PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_uk.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_uk.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_uk.aux tos_uk.log tos_uk.out tos_uk.toc tos_uk.fls tos_uk.fdb_latexmk tos_uk.synctex.gz

echo "PDF compilation completed: tos_uk.pdf"
exit 0
