#!/bin/bash

shopt -s nullglob

pandoc -s ./os/*.md ./app/*.md ./net/*.md --listings --template=template.tex --latex-engine=xelatex -o CompetitionGuide.pdf