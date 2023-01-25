# Quality of Service

Le _applicazioni multimediali_ sono molto diverse da quelle tradizionali in quanto potrebbero necessitare di alcuni requisiti di _qualità del servizio_, come ad esempio la latenza, la banda o la perdita di pacchetti. In tali applicazioni il flusso di dati è continuo e il profilo generato deve essere lo stesso di quello ricevuto, in modo che il ricevitore possa riprodurre le informazioni che riceve e mostrarlo all'utente (senza temporizzazione o memorizzazione).

Per questo tipo di applicativi è dunque necessario parlare di **Quality of Service**, ovvero di un meccanismo in grado di garantire una certa qualità del servizio.

## Requisiti

I requisiti di rete per garantire un Quality of Service sono i seguenti:

- **Streaming**, il flusso di dati deve essere continuo. E' concessa una tolleranza nella perdita del pacchetto, ma è necessario un ritardo che sia al più costante.
- **Interattività**, con una persona o un computer mediante un tempo di risposta basso.
- **Trasmissione su larga banda**: deve essere disponibili una quantità elevata di risorse, capacità elevata e molta memoria nei nodi.
- Comunicazioni di gruppo, ovvero la possibilità di gestire comunicazioni _molti a molti_..

Il vero problema che però deve essere risolto è il ritardo. Oltre ai tempi di elaborazione, ai nodi potrebbe esserci congestione, perciò se vi sono molti pacchetti che vogliono uscire tutti dallo stesso link questi non possono uscire  tutti  insieme,  ma  vengono  inseriti  in  un  buffer.  Ciò  comporta  che  i  pacchetti  attendono  e  questo  si trasforma in un ritardo variabile a seconda del carico del nodo.

:::danger
**Importante:** Il ritardo di attraversamento dei nodi dipende dal traffico istantaneo, non solo dalla quantità ma anche dalla tipologia del traffico.
:::

## Contromisure

Per riuscire a garantire la qualità del servizio sono necessarie molte risorse, una alta capacità trasmissiva, buffer più grandi dei nodi, capacità di commutazione e infine capacità di commutazione (switching).

A livello di pacchetto è necessario applicare delle particolari _policy_ o _traffic shaping_ (tecnica di gestione della congestione), mentre a livello di flusso è necessario effettuare delle segnalazioni per riservare le risorse mediante protocolli quali RSVP (**R**esource re**S**er**V**ation **P**rotocol) per IP e UNI (User to Network Interface) per ATM.

Si vede necessario applicare aa priori il _network engineering_, dimensionando la rete in accordo al traffico previsto e limitando il numero di utenti che possono accedere alla rete, e il _traffic engineering_ per controllare la distribuzione del traffico sulla rete.

Le contromisure che si possono realizzare nella rete sono le seguenti:

- **Classificazione del traffico**: si identificano i pacchetti che necessitano di QoS.
- **Algoritmi sofisticati di scheduling**: scegliere quali pacchetti prendere dal buffer per inviarli
all’esterno.
- **Controllare il traffico che entra nella rete**: se i pacchetti in arrivo sono molti, non è possibile fare altrimenti se non scartare dei pacchetti, e in tal caso non si può garantire QoS. Ciò può essere fatto a vari livelli, oppure effettuando un routing che tenga conto del QoS.

:::tip
**In altre parole**: è necessario limitare la quantità di pacchetti che arrivano ai nodi di rete e gestire in modo appropriato i pacchetti che hanno bisogno specifico di QoS.
:::

### Classificazione

Per effettuare la **classificazione** del traffico è necessario individuare univocamente i pacchetti che appartengono a una determinata comunicazione. Oer farlo sono necessari i seguenti campi:

- IP sorgente
- IP destinazione
- protocollo di trasporto
- porta destinazione
- porta sorgente

Per riuscire a classificare tali pacchetti è dunque necessario un componente hardware denominato **ASIC** _(Application Specific Integrated Circuit)_ oppure le memorie **CAM** _(Content Addressable Memory)_ dove si può dare un indirizzo e invece di ricevere in risposta il contenuto di una cella si può dare una quintupla per avere indietro il tipo di QoS.

### Scheduling

Per effettuare lo scheduling è possibile utilizzare una coda FIFO, ma non risolve il problema in quanto l'ultimo pacchetto a uscire sarà sempre l'ultimo in ingresso, senza dare precedenze. L'effetto che si ottiene è un **multiplexing statistico**, ovvero i pacchetti vengono sequenziati sul link di uscita in modo casuale in base all'ordine di arrivo.

![Multiplexing statistico](../images/09_statistical_multiplexing.png)

Al fine di garantire il singolo flusso è necessario analizzare tutti i pacchetti e inserirli in code multiple servite in base alla priorità, alcuni algoritmi di scheduling sono:

- _Priority Queuing_
- _Round Robing_
- _Class Based Queuing_
- _Weighted Fair Queuing_: sapendo il tipo di traffico di ogni applicazione è possibile configurare i nodi in modo da rispettare i requisiti.
- _Deadline queuing_: è possibile impostare un deadline per ogni pacchetto, in modo da garantire che il pacchetto venga inviato entro un certo tempo.

![Multiple Queue](../images/09_multiple_queue.png){width=400px}

Esistono due standard per supportare il QoS:

- **IntServ**
- **DiffServ**

## IntServ

IntServ garantisce il _QoS_, effettua la prenotazione delle risorse (RSVP) riuscendo a garantire QoS a ogni singolo flusso.

Ha come criticità la complessità e la bassa scalabilità. Tutto ciò però è molto complesso e poco scalabile. Per quanto lo standard sia pronto e implementato nei router, non viene utilizzato.

## DiffServ

**DiffServ** non garantisce il QoS e non consente di riservare le risorse.

Distingue il traffico in classi diverse identificate dal campo DS Field.  Combinando  questa  differenziazione,  insieme  al  network/traffic  engineering  e  all’accesso controllato, è possibile limitare i pacchetti presenti nel buffer. 

Purtroppo soffre di bassa efficienza (best effort), ma consente semplicità e scalabilità. 

:::note
Nell'ultimo periodo è sempre più utilizzato.
:::