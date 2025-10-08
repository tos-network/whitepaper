#!/bin/sh

# Compile PDF using local MacTeX installation (Portuguese version)

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Portuguese PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_pt.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_pt.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_pt.aux tos_pt.log tos_pt.out tos_pt.toc tos_pt.fls tos_pt.fdb_latexmk tos_pt.synctex.gz

echo "PDF compilation completed: tos_pt.pdf"
exit 0

# Alternative: Online compilation (commented out)
# tar cjf tos_pt.tar.bz2 tos_pt.tex logo-transparent-128x128.png logo-transparent-400x400.png
# curl -o tos_pt.pdf --post301 --post302 --post303 -F file=@tos_pt.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos_pt.tex&command=pdflatex"
# rm tos_pt.tar.bz2
