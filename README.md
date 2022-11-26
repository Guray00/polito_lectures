# polito_lectures

Appunti presi durante i corsi di Computer Engineering.

## Tecnologie

Per la generazione dell'output viene utilizzato:

- [Pandoc Latex Template](https://github.com/Wandmalfarbe/pandoc-latex-template), per i PDF
- [Easy Pandoc Templates](https://github.com/ryangrose/easy-pandoc-templates), per la versione WEB.

## Requisiti

Per eseguire la compilazione devono essere correttamente installati:

- [Pandoc Latex Template](https://github.com/Wandmalfarbe/pandoc-latex-template)
- [Easy Pandoc Templates](https://github.com/ryangrose/easy-pandoc-templates)
- [Latex](https://miktex.org/download)
- [Pandoc](https://pandoc.org/installing.html)

## Utilizzo

### Inclusione file

Inserisci nel file `includes.txt` i file da includere, uno per riga. I file con le immagini devono essere inseriti nella cartella `images` mentre i capitoli devono essere inseriti nella cartella `chapters`.

_nota: nel file includes non bisogna specificare `./chapters/`, quindi il file in `./chapters/capitolo1.md` verrà indicato con `capitolo1.md`_

### Configurazione

La configurazione contenente titolo, autore ecc è contenuta nel file `config.yaml`.

### Compilazione

Per compilare il progetto sia in formato pdf che html è sufficiente avviare lo script `compile.bat`, automaticamente verrà generato il file pdf e html all'interno della cartella `output`, con il nome della cartella corrente.

## Installazione

### Installa Latex

Scarica l'ultima versione di Latex da [miktex](https://miktex.org/download) e installalo mediante l'installer.

### Installa Pandoc

Scarica l'ultima versione di [Pandoc](https://pandoc.org/installing.html) e installalo mediante l'installer.

### Installa Pandoc Latex Template

Esegui il clone (o scarica lo zip da GitHub) di [Pandoc Latex Template](https://github.com/Wandmalfarbe/pandoc-latex-template)

```bash
git clone https://github.com/Wandmalfarbe/pandoc-latex-template
```

Copia il file `eisvogel.latex` al seguente path (se qualche cartella non esiste, creala):

- Linux: `~/.pandoc/templates`
- Windows: `C:\Users\USERNAME_HERE\AppData\Roaming\pandoc\templates`

### Installa Easy Pandoc Latex Template

Esegui il clone (o scarica lo zip da GitHub) di [Easy Pandoc Templates](https://github.com/ryangrose/easy-pandoc-templates)

```bash
git clone https://github.com/ryangrose/easy-pandoc-templates
```

Copia i file contenuti in `html` al seguente path (se qualche cartella non esiste, creala):

- Linux: `~/.pandoc/templates`
- Windows: `C:\Users\USERNAME_HERE\AppData\Roaming\pandoc\templates`
