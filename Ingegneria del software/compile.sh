#!/bin/sh

# nome del file di output, modifica questo campo per avere un nome personalizzato
OUTPUT=

# se non viene inserito un nome, lo si recupera dal nome della cartella
if [ -z "$OUTPUT" ]
then
      OUTPUT=$(basename "$PWD") 
fi

# crea la cartella per gli output
mkdir -p output


# nomi dei file di output che verranno generati
PDFNAME="./output/${OUTPUT}.pdf"
WEBNAME="./output/${OUTPUT}.html"
EPUBNAME="./output/${OUTPUT}.epub"


# recupera la lista di file contenuti in includes.txt
readarray -t files < ./includes.txt

# notifica l'utente della creazione del file
str_files=
arraylength=${#files[@]}
for (( i=0; i<${arraylength}; i++ ));
do
  echo "${files[$i]}"
  files[$i]="./chapters/${files[$i]}"
  str_files+="${files[$i]} "
done
echo 

# esegue il comando di creazione
echo Creazione "${OUTPUT}.pdf" in corso...
pandoc -s %files% -o ${PDFNAME} --from markdown --template eisvogel --listings --number-sections -V lang=it --top-level-division=chapter -V toc=true --resource-path="./output/" --standalone --embed-resources --metadata-file=config.yaml # --filter pandoc-latex-environment
echo Compilazione PDF terminata.
echo

# export per la visualizzazione web
echo Creazione "${OUTPUT}.html" in corso...
pandoc -s %files% -o ${WEBNAME} --template=elegant_bootstrap_menu.html --toc --standalone --embed-resources --resource-path="./output/" --metadata-file=config.yaml
echo Compilazione HTML terminata.
echo

# export per la visualizzazione epub
echo Creazione "${OUTPUT}.epub" in corso...
pandoc -s %files% -o ${EPUBNAME} --standalone --embed-resources --resource-path="./output/" --metadata-file=config.yaml --toc --css ./assets/epub.css
echo Compilazione EPUB terminata.
echo

# --resource-path="./output/" specifica a partire da quale path recuperare le risorse, lo rende coerente al md
# --standalone --embed-resources permette il funzionamento anche fuori dalla cartella

echo Esportazione terminata.