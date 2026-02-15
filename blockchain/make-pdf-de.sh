#!/bin/sh

# Compile German PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling German PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_de.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_de.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_de.aux tos_de.log tos_de.out tos_de.toc tos_de.fls tos_de.fdb_latexmk tos_de.synctex.gz

echo "German PDF compilation completed: tos_de.pdf"
exit 0
