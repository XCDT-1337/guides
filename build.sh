#!/bin/bash

shopt -s nullglob

# ./os/*.md ./app/*.md ./net/*.md

pandoc -s ./os/*.md ./app/*.md ./net/*.md --listings --template=template.tex --latex-engine=xelatex -o CompetitionGuide.pdf

#pandoc -s file1 file2 file3 ...  --listings ...
