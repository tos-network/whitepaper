#!/bin/sh

# Compile Spanish PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Spanish PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_es.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_es.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_es.aux tos_es.log tos_es.out tos_es.toc tos_es.fls tos_es.fdb_latexmk tos_es.synctex.gz

echo "Spanish PDF compilation completed: tos_es.pdf"
exit 0
