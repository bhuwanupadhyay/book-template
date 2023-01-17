#!/bin/bash
set -e

echo "##"
echo "# building books"
echo "##"
echo ""


compile_pdf() {
    draft_dir="${1%.*}"
    echo "Book Draft Dir: $draft_dir"
    mkdir -p build/$draft_dir/pdf/
    pandoc \
        --template=./templates/eisvogel.tex \
        --from markdown \
        --toc -N \
        --listings \
        --filter pandoc-crossref \
        --lua-filter=./templates/pagebreak.lua \
        -o build/$draft_dir/pdf/output.pdf \
        $draft_dir/metadata.yaml \
        $draft_dir/*/*.md
    # --top-level-division=chapter \
    # -V book \

}

for f in *.draft; do
    echo "Book Name: $f"
    compile_pdf "$f"
done
