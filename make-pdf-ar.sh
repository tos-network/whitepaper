#!/bin/sh

# Compile Arabic PDF using local MacTeX installation

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Arabic PDF using local MacTeX..."

# First compilation - using XeLaTeX instead of LuaLaTeX for better RTL/LTR handling
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/xelatex -interaction=nonstopmode tos_ar.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/xelatex -interaction=nonstopmode tos_ar.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_ar.aux tos_ar.log tos_ar.out tos_ar.toc tos_ar.fls tos_ar.fdb_latexmk tos_ar.synctex.gz

echo "PDF compilation completed: tos_ar.pdf"
exit 0

# Alternative: Online compilation (commented out)
# tar cjf tos_ar.tar.bz2 tos_ar.tex logo-transparent-128x128.png logo-transparent-400x400.png
# curl -o tos_ar.pdf --post301 --post302 --post303 -F file=@tos_ar.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos_ar.tex&command=pdflatex"
# rm tos_ar.tar.bz2
