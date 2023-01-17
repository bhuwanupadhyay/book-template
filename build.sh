#!/bin/bash
set -e

echo "##"
echo "# building book"
echo "##"
echo ""

rm -rf build/
mkdir -p build/

compile_epub() {
    pandoc \
        --filter pandoc-crossref \
        --css templates/epub.css \
        --toc -N \
        -o build/output.epub \
        metadata.yaml \
        markdown/*/*.md
}

compile_pdf() {
    pandoc \
        --pdf-engine=xelatex \
        --template=./templates/eisvogel.tex \
        --from markdown \
        --toc -N \
        --listings \
        --filter pandoc-crossref \
        --lua-filter=./templates/pagebreak.lua \
        -o build/output.pdf \
        metadata.yaml \
        markdown/*/*.md
}

compile_pdf
compile_epub
