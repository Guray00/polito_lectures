# polito_lectures

[![wakatime](https://wakatime.com/badge/user/374e1d76-0559-4ac6-89f1-96a22a7a774f/project/a36010c1-5c01-4e4f-970c-a54c5dd3c868.svg)](https://wakatime.com/badge/user/374e1d76-0559-4ac6-89f1-96a22a7a774f/project/a36010c1-5c01-4e4f-970c-a54c5dd3c868)

Appunti presi durante i corsi di Computer Engineering orientamento _software_, presso il Politecnico di Torino.

***Ti piace come sono gestiti questi appunti? Dai un'occhiata a questo template che ho realizzato per la generazione di appunti in formato PDF, WEB ed EPUB!***

```text
https://github.com/guray00/template_lectures
```

## Download

L'ultima versione di ciascun appunto è disponibile nella seguente tabella:

<table>
<tr>
	<td> Materia
	<td> PDF
	<td> WEB
	<td> EPUB
<tr>
	<td> Architetture e sistemi di elaborazione
	<td> 
		<a href="https://github.com/Guray00/polito_lectures/raw/main/Architetture%20e%20sistemi%20di%20elaborazione/output/Architetture%20e%20sistemi%20di%20elaborazione.pdf">PDF</a>
	<td> Non disponibile
	<td> Non disponibile
<tr>
	<td> Tecnologie e servizi di rete
	<td> 
		<a href="https://github.com/Guray00/polito_lectures/raw/main/Tecnologie%20e%20Servizi%20di%20Rete/output/Tecnologie%20e%20Servizi%20di%20Rete.pdf">PDF</a>
	<td> Non disponibile
	<td> Non disponibile
</table>

## Tecnologie

Per la generazione dell'output viene utilizzato:

- [Pandoc Latex Template](https://github.com/Wandmalfarbe/pandoc-latex-template), per i PDF
- [Easy Pandoc Templates](https://github.com/ryangrose/easy-pandoc-templates), per la versione WEB

## Requisiti

Per eseguire la compilazione devono essere correttamente installati:

- [Pandoc Latex Template](https://github.com/Wandmalfarbe/pandoc-latex-template)
- [Easy Pandoc Templates](https://github.com/ryangrose/easy-pandoc-templates)
- [Latex](https://miktex.org/download)
- [Pandoc](https://pandoc.org/installing.html)

## Utilizzo

### Inclusione file

Inserisci nel file `includes.txt` i file da includere, uno per riga. I file con le immagini devono essere inseriti nella cartella `images` mentre i capitoli devono essere inseriti nella cartella `chapters`.

_**Nota**: nel file includes non bisogna specificare `./chapters/`, quindi il file in `./chapters/capitolo1.md` verrà indicato con `capitolo1.md`_

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
