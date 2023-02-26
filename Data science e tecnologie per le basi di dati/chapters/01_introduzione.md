# Introduzione
<!-- Lezione 1 - 2022/09/28 -->

E' possibile utilizzare dati di natura eterogenea per la gestione delle emergenze, adoperando delle "observation" (dati molto complessi), storici, stagionali (meteo, territorio).

La maggior parte delle applicazioni utilizzano dato di tipo eterogeneo, raccolti in un data center organizzato in modo da raccogliere flussi di dato diverso da fonti diverse in modo da poterlo elaborare prima di essere sostituito. Questo non è dunque uguale per tutti gli utenti in quanto utenti diversi potrebbero avere risultati differenti.

I dati sono generati da:

- utenti, mediante social media ecc
- health and scientific computing
- log files
- internet of things

L'insieme di questi dati permettono di migliorare il servizio, opportunità di business o servizi personalizzati.

Il volume deve scalare del tempo e deve essere di grande dimensione, con un flusso che deve essere in continua crescita. Per fare ciò è necessario avere architetture, algoritmi e tecniche che consentono di analizzare e processare questi volumi di dati. 

L'obbiettivo finale è quello di creare un nuovo valore al dato, in modo da offrire servizi più personalizzati per gli utenti migliorando l'esperienza.

## Le V del Big Data

Le big data sono caratterizzate da 5 V:

- Volume: il dato deve essere di grande dimensione, con un flusso che deve essere in continua crescita. Se il volume diminuisce, cala anche la nostra capacità predittiva (es diminuzione aerei per il covid)
- Velocity: la velocità di raccolta deve essere molto alto, con hardware e software in grado di gestire tale flusso. I dati di tipo streaming hanno bisogno di restituire il dato nel minor tempo possibile, con il near real time ovvero il minor tempo possibile (a seconda delle operazioni da svolgere sopra). I dati possono essere crowdsourcing (dispositivo invia dati che vengono raccolti) mentre mappe sono dati più statici.
- Variety: i dati che utilizziamo hanno formati e strutture differenti.
- Veracity: accuratezza, il dato deve essere di buona qualità in quanto se è scarsa non è possibile adoperarlo per le analisi. Va monitorato costantemente e verificato.
- Value: deve essere creato un valore aggiunto, trasformando il dato in un vantaggio business.

## Data Science

E' necessario utilizzare dei nuovi paradigmi di programmazione e nuove tecnologie. La capacità di gestire il dato nel modo migliore che fa parte della data science

data science: estrarre conoscenza da grossi volumi di dati, mediante tecniche di statistica, machine learning ecc. Soluzione che combina approcci che sono tipici in modo da modellare una cosa che ha più sfacettature.

Il dato viene modellato partendo dai dati a disposizione, mediante un processo di data science. Questo prevede diversi step:

- Generation: storicizzare il dato, che viene preprocessato mediante data cleaning e data fusion (se le sorgenti sono più di una). Quando è pronto per l'analisi. Trasformed data (?) in modo da estrarre conoscenza.
- Acquisition:
- Storage:
- Analysis: 

algoritmi: strumenti per estrarre conoscenza


## Machine learning and data mining

Le tecniche di Machine learning and data mining cercano di estrarre conoscenza dai dati di tipo implicito, ovvero non nota ma potenzialmente utile. Modellano il contesto tramite i dati includendo conoscenza con lo scopo di individuare relazioni tra i dati.

l'estrazione è di tipo automatico.

I modelli sono di tipo data driven.

Un esempio di utilizzo è il profiling: quando cerchiamo un prodotto compaiono quelli correlati che vengono estratti analizzando gli acquasti fatti nel tempo individuando le correlazioni tra i prodotti. Un altro esempio è il click-stream, ovvero le occorrenze di pagine che sono state visitate insieme.

Un altro caso sono i dati che vengono resi disponibili sui social (genere, nazionalità, data di nascita) che vengono unite a informazioni più dinamiche che vengono condivise dagli utenti, in modo da capire le preferenze.

Le tecniche utilizzate sono **general purpose**, ovvero possono essere utilizzate per scopi diversi.

## Knowledge Discovery Process

Il processo di knowledge discovery è un processo iterativo che prevede:

- **Selection**
- **Preprocessing**
- **Transformation**: modellare il data set in uno spazio diverso.
- **Machine learning / data mining**
- **Interpretation**: si interpretano i risultati eseguendo degli esperimenti.

Solitamente non viene svolto su tutti i dati, ma prima su un campione rappresentativo di quello di partenza in modo da identificare la pipeline corretta.

Il data scientist modella l'applicazione dai dati.

## Preprocessing

Nel preoprocessing si esegue il data cleaning, ovvero quella operazione che si occupa di:

- rimuovere e ridurre i dati rumorosi (dato di qualità scarsa)
- identificare e rimuovere gli outlier (evento raro)
- risolvere le inconsistenze in caso siano presenti più sorgenti

Inoltre viene effettuato il data integration:

- riunire i dati estratti da sorgenti differenti
- integrare i metadati
- identificare e risolvere i conflitti tra i dati
- gestire le ridondanze

I dati ottenuti dal mondo reale sono "sporchi", è dunque necessario eseguire delle operazioni preliminari per ottenere dei dati di buona qualità che deve essere identificata prima di eseguire gli esperimenti.

Il preprocessing prende molto tempo, circa il 80-90% del tempo totale. E' importante capire le sorgenti dei dati, catalogarli e capire da dove arrivano.

## Tipologie di algoritmi

### Regole di associazione

Tecniche che consentono di estrarre le informazioni frequenti da un database transazionale.

:::note
Nasce negli anni 90, commissionato per la prima volta dal Wallmart per ridurre il tempo della spesa per i propri clienti.
:::

### Classificazione

identifica le correlazioni frequenti tra gli oggetti di dato. Si può usare in qualsiasi tipo di dato, di fatto è general purpose. Consente la predizione di una etichetta di classe ovvero un database che contiene dei dati e la categoria di appartenenza. Un esempio è una collezione di immagini a cui ognuna è identificata da una classe. Questo dataset può essere usato per fare training che genera mediante machine learning un modello.

Inoltre, definisce un modello interpretabile per un dato fenomeno.

La classificazione è di tipo supervised, in quanto è presente una conoscenza a priori che viene utilizzata per l'addestramento.

![Classificazione](../images/01_classificazione.png){width=350px}

### Clustering

E' una tecnica unsupervised, in quanto non sono necessari dei dati a priori. Vengono identificati dei gruppi di oggetti di dato simili tra loro. E' la tecnica che divide un insieme di dati in sottogruppi omogenei. Il risultato non è ideale ma fa una prima divisione.

![Clustering](../images/01_clustering.png){width=350px}

### Altre tecniche di data mining

Altre tecniche sono:

- Sequence mining:
- Time series and geospatial data: concetto di tempo e spazio.
- Regression: statistica, servono per fare la predizione di un valore reale (piuttosto che la categoria).
- Outlier detection: utilizzo di tecniche specifiche o di clustering

## Il processo del data science

- What question are you answering?
- What is the right scope of the project?
- What data will you use?
- What techniques are you going to try?
- How will you evaluate your result?
- What maintenance will be required?

In un progetto sono necessarie figure diverse:

- esperto dei dati: caratteristiche, distribuzione, come vengono modellati
- tecniche utilizzate
- visualizzazione dei dati
- esperto di dominio, ovvero la conoscenza del dominio dell'applicazione
- esperto di business: valuta se genera un valore aggiunto economico

## Alcuni problemi

E' importante gestire i dati nel modo giusto attraverso un processo di analisi trasparente. Spesso i dati sono accurati ma richedono degli approfondimenti ovvero "open issue" ovvero l'impatto sociale che questi possono avere. I modelli generati dalle reti neurali sono della black box, ovvero non è possibile vedere come è stato eseguito l'apprendimento dall'utente finale.

I modelli possono essere biased perchè i dati analizzati nei training avevano delle informazioni parziali.