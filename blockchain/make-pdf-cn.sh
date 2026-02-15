#!/bin/sh

# Compile Chinese PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Chinese PDF using local MacTeX..."

# First compilation
echo "Compiling Chinese PDF (first pass)..."
/Library/TeX/texbin/xelatex tos_cn.tex

# Second compilation for cross-references
echo "Compiling Chinese PDF (second pass for cross-references)..."
/Library/TeX/texbin/xelatex tos_cn.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_cn.aux tos_cn.log tos_cn.out tos_cn.toc tos_cn.fls tos_cn.fdb_latexmk tos_cn.synctex.gz

echo "Chinese PDF compilation completed: tos_cn.pdf"
exit 0
