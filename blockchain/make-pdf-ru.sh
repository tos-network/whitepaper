#!/bin/sh

# Compile Russian PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Russian PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_ru.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_ru.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_ru.aux tos_ru.log tos_ru.out tos_ru.toc tos_ru.fls tos_ru.fdb_latexmk tos_ru.synctex.gz

echo "PDF compilation completed: tos_ru.pdf"
exit 0
