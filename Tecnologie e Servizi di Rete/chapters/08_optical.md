
# Rete Ottica

Con rete ottica non si fa riferimento al trasferimento su un cavo di fibra ottica, ma bensì sulla **comunicazione ottica**.

Il concetto principale dietro alle reti ottiche è il **Wavelength Division Multiplexing** _(WDM)_, ovvero la possibilità di trasmissione di frequenze diverse sullo stesso mezzo. Si divide in due tipi:

- **DWDM**: _Dense WDM_, consente la trasmissione di decine o centinaia di segnali sulla stessa fibra, consentendo l'aumento della capacità sui cavi esistenti.
- **CWDM**: _Coarse WDM_, usa più finestre (frequenza diverse) per la trasmissione. Ha un minor numero di lunghezze d'onda, ma è più economico.

Inizialmente la ragione per cui è stato realizzato _WDM_ era per poter riutilizzare la stessa fibra. Solo successivamente  si  è  notato  che  avendo  tanti  segnali  ottici si  potrebbe costruire  un  commutatore  che riconosce  i  vari  canali  e  li  inoltra  su  diverse  fibre, ovvero un **wavelength switch** (commutatore ottico). L’idea alla base delle reti ottiche è di fare reti in cui i nodi sono collegati da fibre e sono in grado di **commutare canali ottici da una fibra di ingresso a una fibra di uscita**.

![Wavelength Switching](../images/08_wavelength_switching.png){width=400px}

Le  reti  ottiche  si  utilizzano  al  centro  delle  reti  in quanto consentono di  commutare  un  canale  ottico.  Inoltre, il commutatore ottico ha le potenzialità di essere **molto semplice**, infatti la tecnologia del DWDM ha permesso di abbassare i costi e di aumentare tanto le prestazioni.

![Switch Ottici](../images/08_optical_switches.png){width=400px}

<!-- 
## Storia

Nelle reti odierne il traffico sta crescendo rapidamente, ma è interesse dell'utente che il prezzo non aumenti nel tempo. DWDM è riuscito a soddisfare questo requisito e grazie alla commutazione ottica è stato possibile ottenere risultati ancora migliori.

![Andamento del traffico](../images/08_traffic_dilemma.png){width=400px}
-->

## Switching Core

Esistono differenti tipologie di _Optical Switch_, che consentono differenti livelli di complessità e di flessibilità, che si distinguono per alcune caratteristiche:

- ottici o elettronici
- cross connect o switch
- wavelength conversion

### Optical Core

Un **Optical Core** utilizza le proprietà fisiche di alcuni materiali per deflettere la luce da una fibra di ingresso verso una fibra di uscita.

Esistono più tipologie:

- **Tilting mirrors**: _Micro-Electro-Mechanical System_ (MEMS), sono apparati meccanici sensibili agli eventi esterni (ad esempio un treno in corsa che genera vibrazioni).
- **Superfici riflettenti olografiche**:  lavorano mediante il voltaggio.
- Materiali che cambiano le proprietà riflettive in base a calore, pressione e voltaggio/corrente.

Le proprietà dei componenti ottici sono le seguenti:

- _potenzialmente_ **poco costosi**, ma non ancora economici.
- **Bit rate e segnale indipendente**, consentendo alta scalabilità e multi standard.
- **Basso consumo di energia**.

Gli aspetti invece negativi sono **alti prezzi** di produzione (attualmente) e un **alta attenuazione** in quanto non vi è rigenerazione del segnale.

:::note
**Nota**: I MEMS sono quelli che hanno ottenuto più successo.
:::

### Electronic Core

Gli **Electronic Core** consentono dei prezzi più bassi rispetto ai MEMS. Converte un segnale ottico in uno elettrico verso un circuito elettronico. Quello che compie è ricevere dei bit ed effettuarne uno switch.

Purtroppo, si perde tutte le proprietà dei componenti ottici, in quanto **non si ha indipendenza** del bit rate rispetto al segnale, il consumo non è basso ed i costi sono più sostenuti (anche se, attualmente, più economici). Un grande vantaggio è un migliore rapporto complessità/costi rispetto al packet switching.

## Switching Dynamics

### Cross Connect

Solitamente vengono adoperati core ottici. Le configurazioni sono fixed/statiche, mediante un sistema/interfaccia di configurazione.

### Fiber Cross Connect

Nel **Fiber Cross Connect** tutti i segnali da una fibra di ingresso vengono mandati su una fibra di uscita. Vengono adoperati dei micro-electro-mechanical system (MEMS) ma che richiedono molto tempo per essere riconfigurati.

A volte viene utilizzata un amplificatore ottico dopo e prima della commutazione (switching).

### Wavelength Cross Connect

Nel **Wavelength Cross Connect** uno o più wavelength vengono mandate da una fibra in input verso una fibra in output. E' presente un WDM de-multiplexer+MEMS a separare le differenti wavelength nello spazio (prism).

La rigenerazione del segnale potrebbe essere utilizzata prima e/o dopo la commutazione (switching), ad esempio la conversione **OEO** (optical-electrical-optical) consente di rigenerare elettronicamente, anche se dipende dal bit rate.

## Wavelength Conversion

La **Wavelength conversion** è complessa, spesso realizzata mediante **EOE**, e richiede un **costo elevato**. Non è trasparente per i dati e non consente di scalare.

Dal punto di vista fisico si comporta come una _cassa di risonanza_ _(?)_ mentre dal punto di vista tecnologico non è molto matura.

Non richiede la stessa wavelength end-to-end e non è presente il wavelength assignment problem ($N^2$).

## Combinazioni comuni

### Wavelength cross-connect with Wavelength Conversion

Una (o più) lunghezze d'onda da un ingresso fibra all'altro (o altri) su un'uscita fibra.

Potrebbe essere utilizzato un electrical core in quanto il monitoraggio del segnale è più semplice. Il forward error correction (FEC) del segnale e più semplice e consente di ridurre il rapporto di errore per bit (BER).

Utilizzo di un optical cor con OEO per la conversione.Consente di eseguire rigenerazione del segnale.

![Struttura](../images/09_wave_cross_with_wave_conv.png){width=400px}

### Dynamic Optical Switching

Nel **Dynamic Optical Switching**  può essere presente conversione di lunghezza d'onda.

La configurazione dello switch cambia dinamicamente, in base ad alcuni criteri:

- configurazione
- ora del giorno
- segnalazione dell'end system
- per ogni pacchetto, nel optical packet switching e optical burst switching

Se viene utilizzato un core ottico, nel caso di wavelength conversion è presente anche rigenerazione mediante OEO. Invece nel caso in cui venga adoperato un core elettronico, si adopera SONET/SDH.

## Control Plane

Quello di cui hanno bisogno gli switch ottici sono:

- resource discovery: topologia, access point e identificazione dei nodi, utilizzo delle risorse.
- connection management/signaling: lightpath setup, lightpath take down, ligthpath modification.
- Distribuited routing.
- Mesh/ring network protection e recovery.
- Stabilire un servizio di protezione per le classi.

Ciò che invece è necessario garantire agli utenti è:

- resource discovery: gli indirizzi degli utenti devono essere ragigungibili mediante una rete ottica
- gestire lightpath: setup, take down, modification.
- negoziare protection service classes: protected, unprotected, best effort lightpath.

:::note
tutti gli aspetti introdotti erano già stati presentati attraverso il protocollo ATM, ma il costo per la tecnologia era troppo elevato.
:::

## Data Transport and Protocol Stack

![Incapsulazione](../images/08_incapsulation.png){width=400px}