CC=pandoc
PFLAGS=-f markdown_github --listings --template=template.tex --latex-engine=xelatex 
HFLAGS=-f markdown_github

LINUX=intro/linux.md os/linux/checklist.md os/linux/hardening.md
WINDOWS=intro/windows.md os/windows/checklist.md os/windows/hardening.md

linux-guide.pdf: $(LINUX)
	$(CC) $(PFLAGS) -s $^ -o out/$@

linux-guide.html: $(LINUX)
	$(CC) $(HFLAGS) -s $^ -o out/$@

linux: linux-guide.pdf linux-guide.html

windows-guide.pdf: $(WINDOWS)
	$(CC) $(PFLAGS) -s $^ -o out/$@

windows-guide.html: $(WINDOWS)
	$(CC) $(HFLAGS) -s $^ -o out/$@

windows: windows-guide.pdf windows-guide.html

all: windows linux