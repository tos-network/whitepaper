#!/bin/sh

# Compile Italian PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Italian PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_it.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_it.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_it.aux tos_it.log tos_it.out tos_it.toc tos_it.fls tos_it.fdb_latexmk tos_it.synctex.gz

echo "PDF compilation completed: tos_it.pdf"
exit 0
