@ECHO OFF

for /d %%I in (*) do (
    cd ".\%%I" & call .\compile.bat --quick & cd ".."
)

:: genera l'index
pandoc --standalone -c github.css -f gfm -t html README.md -o index.html --metadata title="Dispense"

timeout 5