@ECHO OFF

:: permette di stampare in utf-8
REM change CHCP to UTF-8 > nul
CHCP 65001 > nul

:: nome del file di output, modifica questo campo per avere un nome personalizzato
set OUTPUT=

:: se non viene inserito un nome, lo si recupera dal nome della cartella
if [%OUTPUT%] == [] (
for %%I in (.) do set OUTPUT=%%~nxI
)

:: verifico che pandoc sia effettivamente installato
pandoc --version 1> nul 2>nul || (
echo [ERROR] Pandoc non risulta installato.
echo: 
exit /b
)

:: verifico che latex sia effettivamente installato
latex --version 1> nul 2>nul || (
echo [ERROR] Latex non risulta installato.
echo: 
exit /b
)

:: nascondo la cartella .vscode
if exist ".\.vscode" attrib +h ".\.vscode"

:: crea la cartella per gli output
if not exist ".\output" mkdir .\output

:: se non esiste creo il file delle precedenze
if not exist ".\assets\.previous.md" (
copy NUL ".\assets\.previous.md" > nul
attrib +h ".\assets\.previous.md"
)

:: nomi dei file di output che verranno generati
set PDFNAME="./output/%OUTPUT%.pdf"
set WEBNAME="./output/%OUTPUT%.html"
set EPUBNAME="./output/%OUTPUT%.epub"


SETLOCAL EnableDelayedExpansion 

:: verifico se python e il pacchetto "pandoc-latex-environment" per i colorbox sono installati
set PANDOC_LATEX_ENVIRONMENT=
python --version 1> nul 2>nul && python -m pip show pandoc-latex-environment 1>nul 2>nul && (
set PANDOC_LATEX_ENVIRONMENT=--filter pandoc-latex-environment
) || (
echo [WARNING] Si consiglia l'utilizzo del pacchetto "pandoc-latex-environment"
echo [WARNING] Per installare: python -m pip install pandoc-latex-environment
echo: 
)

:: recupera la lista di file contenuti in includes.txt
for /f "Tokens=* Delims=" %%x in (includes.txt) do set files=!files! "./chapters/%%x"

:: creo il file unito
pandoc -s %files% -o ".\assets\.actual.md"
attrib +h ".\assets\.actual.md"


:: verifico se sono presenti differenze
fc ".\assets\.previous.md" ".\assets\.actual.md" > nul && (
echo %OUTPUT% è già aggiornato.
timeout 5
attrib -h ".\assets\.actual.md"
del .\assets\.actual.md
exit /b
)

:: notifica l'utente della creazione del file
echo Creazione in corso dei file:
for /f "Tokens=* Delims=" %%x in (includes.txt) do echo - %%x
echo:

:: esegue il comando di creazione
echo Creazione "%OUTPUT%.pdf" in corso...
pandoc --pdf-engine=xelatex -s %files% -o %PDFNAME% --from markdown --template eisvogel --listings --number-sections --top-level-division=chapter -V toc=true --resource-path="./output/" --standalone --embed-resources --metadata-file=config.yaml %PANDOC_LATEX_ENVIRONMENT% --mathjax
echo Compilazione PDF terminata.
echo:

:: export per la visualizzazione web
echo Creazione "%OUTPUT%.html" in corso...
pandoc -s %files% -o %WEBNAME% --template=elegant_bootstrap_menu.html --toc --standalone --embed-resources --resource-path="./output/" --metadata-file=config.yaml --katex
echo Compilazione HTML terminata.
echo:

:: export per la visualizzazione epub
echo Creazione "%OUTPUT%.epub" in corso...
pandoc -s %files% -o %EPUBNAME% --standalone --embed-resources --resource-path="./output/" --metadata-file=config.yaml --toc --css ./assets/epub.css 
echo Compilazione EPUB terminata.
echo:

:: --resource-path="./output/" specifica a partire da quale path recuperare le risorse, lo rende coerente al md
:: --standalone --embed-resources permette il funzionamento anche fuori dalla cartella
:: --mathjax permette l'uso di formule matematiche

:: aggiorno il file per il controllo del precedente
attrib -h ".\assets\.previous.md"
attrib -h ".\assets\.actual.md"
del ".\assets\.previous.md"
cd assets && ren ".actual.md" ".previous.md" && cd ..
attrib +h ".\assets\.previous.md"

echo Esportazione terminata.
timeout 5