#!/bin/sh

# Compile PDF using local MacTeX installation (Polish version)

# Update PATH to include MacTeX binaries
eval "$(/usr/libexec/path_helper)"

echo "Compiling Polish PDF using local MacTeX..."

# First compilation
echo "Compiling PDF (first pass)..."
/Library/TeX/texbin/pdflatex tos_pl.tex

# Second compilation for cross-references
echo "Compiling PDF (second pass for cross-references)..."
/Library/TeX/texbin/pdflatex tos_pl.tex

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
rm -f tos_pl.aux tos_pl.log tos_pl.out tos_pl.toc tos_pl.fls tos_pl.fdb_latexmk tos_pl.synctex.gz

echo "PDF compilation completed: tos_pl.pdf"
exit 0

# Alternative: Online compilation (commented out)
# tar cjf tos_pl.tar.bz2 tos_pl.tex logo-transparent-128x128.png logo-transparent-400x400.png
# curl -o tos_pl.pdf --post301 --post302 --post303 -F file=@tos_pl.tar.bz2 "https://texlive2020.latexonline.cc/data?target=tos_pl.tex&command=pdflatex"
# rm tos_pl.tar.bz2
