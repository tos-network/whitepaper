#!/bin/sh

# Compile Japanese PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Japanese PDF using local MacTeX..."

# First compilation
echo "Compiling Japanese PDF (first pass)..."
/Library/TeX/texbin/xelatex tos_jp.tex

# Second compilation for cross-references
echo "Compiling Japanese PDF (second pass for cross-references)..."
/Library/TeX/texbin/xelatex tos_jp.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_jp.aux tos_jp.log tos_jp.out tos_jp.toc tos_jp.fls tos_jp.fdb_latexmk tos_jp.synctex.gz

echo "Japanese PDF compilation completed: tos_jp.pdf"
exit 0
