# MPLS
<!-- lezione17: 29-11-2022 -->

**MPLS** è una tecnologia importante in quanto permette la realizzazione di un nuovo tipo di rete pubblica basata su IP, dove con rete pubblica si intende una rete con traffico di diversi utenti e aziende su cui è possibile vendere dei servizi.

Una struttura utilizzata molto in passato era a _"cipolla"_, con vari strati di livelli protocollari che comunicano tra di loro per implementare varie funzionalità. Ciò comportava però una conoscenza orizzontale da parte dei tecnici su più tecnologie che dovevano comunicare tra di loro.

![Struttura a cipolla](../images/07_onion.png){width=400px}

MPLS consente di eliminare questa struttura utilizzando un solo livello protocollare, abbattendo i costi degli operatori.

![La promessa di MPLS](../images/07_onion_mpls.png){width=400px}

L'inoltro dei pacchetti avviene attraverso l'aggiunta di una **etichetta**, in base alla quale il routing effettua il forwarding invece di guardare l'indirizzo IP di destinazione. Il motivo di questo approccio risiede nella maggiore rapidità: se utilizzassimo l'indirizzo di destinazione bisognerebbe eseguire il max prefix routing cercando il prefisso più lungo nel quale l'indirizzo IP di destinazione è contenuto (tabelle molto grandi). Oggi è ancora molto utilizzata per il _traffic engineering_, ovvero distribuire il traffico della rete.

![Etichetta](../images/07_label.png){width=400px}

Quello che fa MPLS è dunque far diventare IP _connection oriented_. Lo svantaggio di tale approccio è la necessità di creare una connessione per la comunicazione per poi eliminarla, ma aver implementato IP in modo connection-less ha però generato dei problemi più grandi.

## Architettura di rete

_MPLS_ non utilizza gli _end system_ e può essere utilizzato in una porzione di una rete, denominata **MPLS Cloud** (non ha correlazione con il cloud computing).

![Architettura di rete](../images/07_na.png){width=400px}

Osservando l'immagine si può vedere:

- **LSR**: Label Switching Router.
- **Label Edge Router**: router che non ha altri router MPLS collegati.
- **LSP**: label switch path, è un percorso di comunicazione attraverso cui viaggiano i pacchetti.

![LSP tunnel](../images/07_lsp_tunnel.png){width=400px}

L'etichetta viene cambiata a ogni nodo, in modo da mantenere una etichetta più corta e poterla riutilizzare senza dover mettere d'accordo i nodi. Questa tecnica prende il nome di **label switching** e consente di ottenere scalabilità.

![Label Switching](../images/07_label_switching.png){width=400px}

Gli elementi chiave di MPLS sono:

- l'header MPLS, che contiene l'etichetta
- protocolli per la distribuzione delle etichette
- protocolli di routing migliorati e modificati

:::tip
**Riassumendo**: Il vantaggio è quello di utilizzare un solo protocollo per la gestione delle comunicazioni tra i nodi e anche verso l'esterno.
:::

## Storia di MPLS

A differenza di _IPv6_, **MPLS** è stato utilizzato da subito in produzione riuscendo a risolvere problemi di attori molto differenti.

Inizialmente venne implementato il _tag switching_ da parte di Cisco nei propri sistemi per sostituire il _longest path matching_.

Fino a qualche anno fa si ipotizzava che lo standard di trasmissione **ATM** _(Asynchronous Transfer Mode)_ avrebbe soppiantato internet in quanto molto superiore, ma ha come problematica il costo troppo elevato per la struttura (nessun problema di risoluzione indirizzi, signaling semplificato e un solo piano di controllo). Una prima soluzione fu quello di utilizzare ATM con IP, riutilizzando l'hardware del ATM switching. Venne successivamente introdotto **MPλS** _(lambda!)_, acronimo di _Multi-Protocol Lambda Switching_.

Ha seguito **G-MPLS** _(Generalized MPLS)_, il quale ha introdotto:

- Packet switching
- Cell switching
- Circuit switching (SONET/SDH)
- Lambda switching
- Anything switching
- Unifying control plane

## Header MPLS

L'header **MPLS** è di livello 2 ed è composta da più moduli uniti, che formano uno shim header, composto da:

- **label**: _20 bit_.
- **exp**: experimental bits, 3 bit.
- **s**: bottom of stack, 1 bit, vale uno se l'ultimo modulo dello stack e zero altrimenti.
- **TTL**: time to live, 8 bit.

Nel caso di _ATM_ e _frame relay_ alcune informazione erano già presenti, per tale motivo si è scelto di riutilizzare alcuni campi invece di aggiungere nuovi moduli:

- _VIC/VPI_ in ATM
- _DLCI_ in frame relay

In questi casi non si guarderà il modulo MPLS ma i suddetti campi dei moduli già presenti. In questo modo il costruttore di apparati ATM non deve cambiare l'hardware ma bensì solamente il software, contribuendo a migliorare lo standard.

## LSP setup

Una **FEC**, _Forwarding Equivalence Class_, è un insieme di pacchetti che hanno lo stesso destinatario, dunque un _LSP_ è un percorso di comunicazione che viene utilizzato per trasportare un FEC. Tali pacchetti sono trattati nello stesso modo da ciascun LSR e seguono la stessa strada in una rete MPLS, ricevendo la medesima label.

Quando viene creato un LSP, sono necessarie tre operazioni da parte degli LSR:

- **label binding**: associazione dell'etichetta.
- **label mapping**: creazione della riga nella tabella di forwarding, tra ingresso e uscita.
- **label distribution**: l'etichetta scelta deve essere comunicata ai nodi vicini (o a un nodo vicino).

### Label Binding

Nel **Label Binding** un _LSR_ determina l'etichetta che deve essere utilizzata per i pacchetti di una determinata FEC. Il binding viene effettuato _downstream_, ovvero tra due nodi che si trovano ai capi di un link quello che esegue il binding è colui che sta a valle. Per sapere di dover usare tale etichetta, l’_LSR_ deve essere notificato, e può farlo in due modi:

- **unsolicited**: senza una richiesta diretta.
- **on**: in seguito a una richiesta.

### Label Mapping

Il label mapping esegue l'associazione tra una etichetta di ingresso, scelta dal _LSR_ considerato, e una etichetta di uscita, scelta dal _downstream LSR_, per riuscire a raggiungere il next hop in base al routing.

### Label Distribution

Quando un router ha effettuato il binding di una etichetta, deve comunicare tale etichetta ai nodi vicini, in modo che questi possano fare il _mapping_ (ameno al nodo di upstream). Tale operazione è detta label distribution e serve a notificare l'etichetta scelta per un dato _FEC_, in seguito al _label binding_.

### Static label binding (and mapping)

Il **label binding statico** avviene attraverso un gestore di rete (in modo equivalente al PVC in ATM). Non è scalabile e non è c'è interoperabilità tra i sistemi di controllo. Inoltre, è impossibile avere _LSP_ tra reti differenti.

### Dynamic label binding
<!-- lezione 18: 30-11-2022 -->

Il label binding avviene in modo dinamico, può essere scatenato in due modi:

- **data/traffic driven**: innescato dall'arrivo di un pacchetto.
- **control driven**: ovvero innescato dai messaggi di controllo che può essere di segnalazione o di routing.

#### Control Driven Label Binding

La creazione degli **LSP control driven** da origine a due tipi di LSP diversi:

- **topology based**: il router scopre che esiste una destinazione, in base alla topologia della rete, dei percorsi e delle destinazioni dunque gli lsr creano degli lsp per le destinazioni.
- **creazione esplicita degli LSPs**: avviene una segnalazione esplicita, inizializzata dagli label edge routers. Avviene on demand.

### Label Distribution Protocol

La distribuzione delle etichette avviene attraverso dei protocolli, in particolare ne esistono 3 (non compatibili):

- **BGP**: utilizzo di un protocollo di routing, solo topology based (quando vengono segnalate le destinazioni vengono mandate anche le etichette).
- **LDP**: _label distribution protocol_, è un'evoluzione del Tag Labelling di Cisco. Poco utilizzato perché si aveva paura di avvantaggiare Cisco, attualmente è deprecato.
- **RSVP**: Resource Reservation Protocol, utilizzato per l'allocazione di servizi integrati all'interno delle reti.

## Protocolli di routing

I protocolli di routing servono per determinare il percorso che sarà compiuto da un LSP, impattando sulla fase di _label mapping_ e determina il _packet routing_.

I protocolli di routing sono in realtà quelli già esistenti:

- _OSPF_
- _IS-IS_
- _BGP-4_

Li utilizziamo per portare informazioni riguardo alle scelte di routing, come:

- capacità dei link
- utilizzo dei link
- dipendenze tra i link (utilizzato per il fault recovery)

Le versioni modificate per il _Traffic Engineering_ prendono il nome di _OSPF-TE_ ed _IS-IS-TE_, dove _TE_ sta per _Traffic Engineering_.

## Routing modes

Le modalità di routing sono 2:

- _hop by hop routing_
- _explicit routing_

### Hop by hop routing

Nel **Hop by hop routing** ciascun LSR decide il prossimo LSR del percorso LSP. Il principio è lo stesso del IP routing tradizionale.

La procedura avviene nei seguenti passi:

- viene scelta una label per l'upstream link (label binding)
- la label viene mappata all'indirizzo della interfaccia del prossimo LSR del next hop
- Label announced dal next LSR

### Explicit constraint based routing

Nel **Explicit constraint based routing** un singolo switch sceglie il percorso per l'intera _LSP_. Il percorso potrebbe non essere ottimale, ma almeno evitiamo il rischio di fare percorsi circolari, realizza dunque esplicitamente il percorso _LSR_. Non è dunque specificato solo il _FEC_ ma anche l'intero percorso (il nodo deve avere le informazioni su tutta la rete).

La scelta del percorso avviene mediante **Constraint Based Routing**, ma la distribuzione delle operazioni tra nodi è impossibile in quanto non c'è un unico criterio per scegliere il percorso e possono esserci vincoli che vanno in conflitto. Inoltre potrebbe essere difficoltoso mantenere i vincoli e le informazioni sincronizzate, in quanto variano più velocemente delle informazioni relative alla topologia.
<!-- da rivedere meglio -->

### Label Distribution Protocol (1)

I protocolli per la distribuzione delle etichette sono modificati in modo da supportare informazioni su quale è il percorso scelto.

In particolare sono utilizzati:

- **CR-LDP**: Constraint based routing label distribution protocol
- **RSVP-TE**: Resource Reservation Protocol Traffic Engineering

Questi devono essere utilizzati con OSPF-TE e IS-IS-TE.

Alcune nuove possibilità date da questi nuovi strumenti sono:

- **traffic engineering**
- garantire la **qualità del servizio** _(QoS)_
- per-class traffic engineering (in sinergia con DiffServ)
- fault recovery rapido, meno di 50 ms

## Traffic Engineering

I pacchetti, quando spediti mediante ip, vengono inviati verso le destinazioni realizzando quello che è un fenomeno a _"imbuto"_ , comportando aggregazione che sfocia in una riduzione delle prestazioni. Una soluzione potrebbe essere comprare nuovi router, ma questi diverrebbero inutili (dopo l'intasamento).

![Aggregazione delle informazioni](../images/07_ip_imbuto.png){width=350px}

Il traffic engineering si pone come soluzione per abilitare la ridistribuzione del traffico **non in base alla destinazione**, ma in modo **omogeneo** evitando la congestione.

Se si scegliesse di inviare pacchetti in modo tradizionale mediante IP in accordo al carico di ogni link, ogni volta che il router ricalcola i percorsi e i next-hop sono cambiati viene aggiornata la tabella in accordo con i nuovi percorsi di rete. Questo causa un inversione di tendenza tra i carichi che iniziano a cambiare molto velocemente causando **instabilità**.

In _MPLS_ non c'è un aggiornamento costante tra piano di controllo e piano dati, a differenza di IP, consentendo il _traffic engineering_. Senza _MPLS_ l'alternativa era _ATM_ con due _control plans_ (i router sono ATM-unware), comportando però una ridotta scalabilità e un alto numero di adiacenze.

MPLS è IP-aware, solo un control plan operativo su una topologia fisica, rendendo il tutto più scalabile e semplice.

MPLS vede alcune estensioni come:

- **MPλS**, ovvero MPLS control plans su rete ottica.
- **GMPLS**, ovvero _Generalized MPLS_, estensione di MPLS per supportare più tipi di rete (pacchetti, circuito, optics, etc).

## CoS e QoS

Le risorse e le modalità di servizio potrebbero essere associate a un FEC nel momento di setup di un LSP. E' richiesto un supporto esplicito nel data plan e control plan del LSR.

### Class of Service (CoS)

La **CoS** _(Class of Service)_ è un insieme di parametri che descrivono il servizio richiesto. Consente una priorità relativa tra _FEC_ differenti ed è in grado di fornire un garanzia assoluta.

Supporta il modello _DiffServ_ con un comportamento _per-hop_, _EF_ (expedite forwarding) e _AF_ (assured forwarding), oltre al class traffic engineering (ds-aware traffic engineering).

### Quality of Service (QoS)

La **QoS** _(Quality of Service)_ garantisce specificatamente:

- bandwitdh
- Delay
- burst size

I vantaggi di QoS in MPLS sono vari, tra questi vi è la possibilità di avere una rete unificata in grado di supportare tutti i tipi di servizi (messaggio di marketing).

Il supporto per QoS e i servizi real time su IP non è ancora pronto.

Molte reti multi servizio utilizzano ora un paradigma "ships in the night", dove i protocolli ATM sono per servizi tipici di ATM ed MPLS control plan è utilizzato per i servizi IP.

## Fast fault recovery

E' garantito il fast fault recovery mediante link re-routing e edge-to-edge re-routing.

Una volta creato l’LSP, se un link si rompe il protocollo di routing se ne accorge e ricalcola la route, ma il piano dati continua a inviare pacchetti in base alla tabella di forwarding che non cambia. Si può
creare un altro LSP che funge da backup del link, fatto non quando il link si rompe ma a priori.

Quando due nodi si scoprono, si creano un LSP lungo la rete che permettano a questi due nodi di inviarsi pacchetti. Se il link diretto si rompe, sarà presente un LSP che permetterà di andare verso Y.

Quando il link si rompe, verrà aggiunta un’ulteriore etichetta a quella già presente. Y saprà che quando arrivano con una certa etichetta (cioè sono per Y) dovrà rimuovere l’etichetta più esterna e procedere normalmente. Tale processo è molto veloce ed è detto link re-routing.

Utilizzare più etichette aiuta a generare una gerarchia tra reti MPLS diverse che contribuisce alla scalabilità della rete. Utile soprattutto per instradare pacchetti in punti geografici molto lontani, quando un ISP non ha connettività diretta verso tale destinazione. Ciò comporta una riduzione delle routing table e delle forwarding table.

![Link re-routing](../images/07_link_rerouting.png){width=300px}

![Edge to edge re-routing](../images/07_e_to_e_rerouting.png){width=300px}

<<!-- slide73? -->

## Gerarchia e scalabilità

Le label MPLS introducono gerarchie su più livelli, a seconda di quanto richiesto per la scalabilità. Le tabelle di routing dei router di transito non devono essere necessariamente complete, in quanto LSP è gestito tra gli edge routers.

In questo modo è più semplice e veloce gestire il match delle label piuttosto che il longest prefix matching.

## Penultimate Hop Popping (PHP)

Nel **Penultimate Hop Popping** _(PHP)_, il penultimo nodo esegue il pop della label dal LSP, in modo da non doverlo fare il nodo di destinazione. Il **Label Edge Router** _(LER)_ indirizza il pacchetto in base all'indirizzo IP (o la prossima label nello stack).

La distribuzione di label 3 indica un implicito PHP, in quanto l'edge router vede che il next hop è all'esterno.

Per qualsiasi router sull'ultimo hop avviene lo swap sull'etichetta 0.
