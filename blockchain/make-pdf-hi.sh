#!/bin/sh

# Compile Hindi PDF using local MacTeX installation with XeLaTeX (for Devanagari support)

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Hindi PDF using local MacTeX with XeLaTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/xelatex tos_hi.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/xelatex tos_hi.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_hi.aux tos_hi.log tos_hi.out tos_hi.toc tos_hi.fls tos_hi.fdb_latexmk tos_hi.synctex.gz

echo "PDF compilation completed: tos_hi.pdf"
exit 0
