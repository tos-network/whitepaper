#!/bin/sh

# Compile Turkish PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Turkish PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_tr.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_tr.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_tr.aux tos_tr.log tos_tr.out tos_tr.toc tos_tr.fls tos_tr.fdb_latexmk tos_tr.synctex.gz

echo "PDF compilation completed: tos_tr.pdf"
exit 0
