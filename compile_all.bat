@ECHO OFF

for /d %%I in (*) do (
    echo: 
    echo ========================================================================
    echo %%I
    echo ========================================================================
    echo: 
    cd ".\%%I" & call .\compile.bat & cd ".."
)

echo:
echo ========================================================================
echo Aggiornamento del readme
echo ========================================================================
pandoc --standalone -c github.css -f gfm -t html README.md -o index.html --metadata title="Dispense"

timeout 5