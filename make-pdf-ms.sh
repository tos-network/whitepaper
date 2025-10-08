#!/bin/sh

# Compile Malay PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Malay PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_ms.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_ms.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_ms.aux tos_ms.log tos_ms.out tos_ms.toc tos_ms.fls tos_ms.fdb_latexmk tos_ms.synctex.gz

echo "PDF compilation completed: tos_ms.pdf"
exit 0
