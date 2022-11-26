@ECHO OFF

:: nome del file di output, modifica questo campo per avere un nome personalizzato
set OUTPUT=

:: se non viene inserito un nome, lo si recupera dal nome della cartella
if [%OUTPUT%] == [] (
for %%I in (.) do set OUTPUT=%%~nxI
)

:: crea la cartella per gli output
if not exist ".\output" mkdir .\output


:: nomi dei file di output che verranno generati
set PDFNAME="./output/%OUTPUT%.pdf"
set WEBNAME="./output/%OUTPUT%.html"
set EPUBNAME="./output/%OUTPUT%.epub"


SETLOCAL EnableDelayedExpansion 

:: recupera la lista di file contenuti in includes.txt
for /f "Tokens=* Delims=" %%x in (includes.txt) do set files=!files! "./chapters/%%x"

:: notifica l'utente della creazione del file
echo Creazione in corso dei file:
for /f "Tokens=* Delims=" %%x in (includes.txt) do echo - "%%x"
echo:

:: esegue il comando di creazione
echo Creazione "%OUTPUT%.pdf" in corso...
pandoc -s %files% -o %PDFNAME% --from markdown --template eisvogel --listings --number-sections -V lang=it --top-level-division=chapter -V toc=true --resource-path="./output/" --standalone --embed-resources --metadata-file=config.yaml
echo Compilazione PDF terminata.
echo:

:: export per la visualizzazione web
echo Creazione "%OUTPUT%.html" in corso...
pandoc -s %files% -o %WEBNAME% --template=elegant_bootstrap_menu.html --toc --standalone --embed-resources --resource-path="./output/" --metadata-file=config.yaml
echo Compilazione HTML terminata.
echo:

:: export per la visualizzazione epub
echo Creazione "%OUTPUT%.epub" in corso...
pandoc -s %files% -o %EPUBNAME% --standalone --embed-resources --resource-path="./output/" --metadata-file=config.yaml --toc --css ./assets/epub.css
echo Compilazione EPUB terminata.
echo:

:: --resource-path="./output/" specifica a partire da quale path recuperare le risorse, lo rende coerente al md
:: --standalone --embed-resources permette il funzionamento anche fuori dalla cartella

echo Esportazione terminata.
timeout 5