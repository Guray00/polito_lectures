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

:: environment variables
SET CHAPTERS_PATH=.\chapters\
SET RESOURCES_PATH=.\chapters\
SET ASSETS_PATH=.\assets\

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
if not exist "%ASSETS_PATH%.previous.md" (
copy NUL "%ASSETS_PATH%.previous.md" > nul
attrib +h "%ASSETS_PATH%.previous.md"
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
for /f "Tokens=* Delims=" %%x in (includes.txt) do set files=!files! "%CHAPTERS_PATH%%%x"

:: creo il file unito
pandoc -s %files% -o "%ASSETS_PATH%.actual.md"
attrib +h "%ASSETS_PATH%.actual.md"


:: verifico se sono presenti differenze
fc "%ASSETS_PATH%.previous.md" "%ASSETS_PATH%.actual.md" > nul && (
echo %OUTPUT% è già aggiornato.
if [%1]==[--quick] (
echo: 
) || (
timeout 5
)
attrib -h "%ASSETS_PATH%.actual.md"
del "%ASSETS_PATH%.actual.md"
exit /b
)

:: -------- stampa --------
set "STR=%OUTPUT%"
set "SIZE=50"
set "LEN=0"

:strLen_Loop
   if not "!!STR:~%LEN%!!"=="" set /A "LEN+=1" & goto :strLen_Loop

set "stars=****************************************************************************************************"
set "stars=***************************************************************************************************"
set "spaces=                                                                                                    "

echo: 
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-2"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
:: ------------------------

:: notifica l'utente della creazione del file
echo: 
for /f "Tokens=* Delims=" %%x in (includes.txt) do echo - %%x
echo:

:: esegue il comando di creazione
echo Creazione "%OUTPUT%.pdf" in corso...
pandoc --pdf-engine=xelatex -s %files% -o %PDFNAME% --from markdown --template eisvogel --listings --number-sections --top-level-division=chapter -V toc=true --resource-path=%RESOURCES_PATH% --standalone --embed-resources --metadata-file=config.yaml %PANDOC_LATEX_ENVIRONMENT% --mathjax
echo Compilazione PDF terminata.
echo:

:: export per la visualizzazione web
echo Creazione "%OUTPUT%.html" in corso...
pandoc -s %files% -o %WEBNAME% --template=%ASSETS_PATH%/theme.html --toc --standalone --embed-resources --resource-path=%RESOURCES_PATH% --metadata-file=config.yaml --katex
echo Compilazione HTML terminata.
echo:

:: export per la visualizzazione epub
echo Creazione "%OUTPUT%.epub" in corso...
pandoc -s %files% -o %EPUBNAME% --standalone --embed-resources --resource-path=%RESOURCES_PATH% --metadata-file=config.yaml --toc --css %ASSETS_PATH%epub.css 
echo Compilazione EPUB terminata.
echo:

:: --resource-path="./output/" specifica a partire da quale path recuperare le risorse, lo rende coerente al md
:: --standalone --embed-resources permette il funzionamento anche fuori dalla cartella
:: --mathjax permette l'uso di formule matematiche

:: aggiorno il file per il controllo del precedente
attrib -h "%ASSETS_PATH%.previous.md"
attrib -h "%ASSETS_PATH%.actual.md"
del "%ASSETS_PATH%.previous.md"
cd "%ASSETS_PATH%" && ren ".actual.md" ".previous.md" && cd ..
attrib +h "%ASSETS_PATH%.previous.md"

echo Esportazione terminata.
if [%1]==[--quick] (
exit /b
) || (
timeout 5
)