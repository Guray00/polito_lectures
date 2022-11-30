# IPv4 Summary
<!-- lezione1: -->
In questo capitolo viene fatto un ripasso generico su quanto visto nei corsi precedenti, con particolare riferimento a Reti Informatiche (o equivalenti).

In ogni sottorete tutti i dispositivi che ne fanno parte avranno lo stesso indirizzo ip.

## Indirizzi speciali

- tutti i bit a 1: indirizzo di broadcast, non può essere assegnato
- `127.x.x.x`: indirizzo di loopback, è una  classe di indirizzi e servono a identificare l'host stesso e per tale motivo vengono solitamente utilizzate a scopo di debug.

Spesso oggi giorno non è consentito l'invio di messaggi in broadcast per motivi di sicurezza.

## Indirizzamento IP con classi

Le rappresentazioni possono essere classes (a classe) o classness (senza l'utilizzo di classi). In particolare esistono di tre tipologie:

- **A**: prevede i primi 8 bit per l'indirizzo di rete, i rimanenti sono per identificare i dispositivi. Il totale degli indirizzi è 2^7 per la rete e 2^24 per i dispositivi. Si possono avere 128 networks.
- **B**: 2 bit per la classe, 14 bit per la rete e 16 bit per i dispositivi. Si possono avere 16384 networks.
- **C**: 3 bit per la classe, 21 bit per la rete e 8 bit per gli host.
- **D**: 4 bit per la classe, 28 bit per la rete e 4 bit per gli host. Questi indirizzi sono riservati per i multicast.

Basta guardare il primo bit per capire se era una classe A, B, C o D.

**Nota**:I bit di riconoscimento servono per sapere quali bit individuano la rete e quali gli host.

## Indirizzamento IP senza classi (CIDR)

Il sistema _**C**lassless **I**nter**D**omain **R**outing_ permette di indirizzare la porzione più precisa di indirizzi tra rete e e dispositivi. La porzione di rete è dunque di lunghezza arbitraria. Il formato con cui può essere rappresentato un indirizzo è il seguente: `networkID + prefix length` oppure `netmask`.

Il prefix length, specificato con `/x`, è il numero di bit  di network.

La netmask è identificata da una serie di bit posti a `1` che determinano quali bit identificano la rete, attraverso un and bit a bit.

_Esempio:_

```text
200.23.16.0/23                # prefix length
200.23.16.0 255.255.255.254.0 # netmask
```

L'indirizzo viene espresso attraverso gruppi di 8 bit, rappresentanti in modo decimale puntato (4 gruppi in quanto 32 bit totali). Ogni raggruppamento avrà un valore da 0 a 255.

Non tutti i valori sono permessi possibili, il più piccolo è 252. Questo è dovuto al fatto che abbiamo l'indirizzo dell'intera sottorete e l'indirizzo del inter broadcast che non possono essere utilizzati nell'assegnazione.

Un modo per sapere se un indirizzo è scritto in modo corretto è prendere il prefix length `/x` e controllare che ci l'ultimo numero puntato sia multiplo di 2^(32-x).

_Esempi:_

```text
130.192.1.4/30  =>  4%2^(32-30) = 4%4  = 0 si!
130.192.1.16/30 => 16%2^(32-30) = 16%4 = 0 si!
130.192.1.16/29 => 16%2^(32-29) = 16%8 = 0 si!

130.192.1.1/30 => 1%2^(32-30) = 1%4  != 0 no!
130.192.1.1/29 => 1%2^(32-29) = 1%8  != 0 no!
130.192.1.1/28 => 1%2^(32-28) = 1%16 != 0 no!
```

Per il ragionamento di sopra appare evidente che un indirizzo che termina con `.1` non sarà mai un indirizzo corretto, in quanto ritornerà sempre un resto.

## IP routing

Il routing degli host avviene attraverso la routing table, caratterizzata da due colonne che identificano:

- **destinazione** (indirizzi ip)
- **interfaccia** (eth0...)

Quando viene inviato un pacchetto, si cerca un match all'interno della tabella per identificare dove inviare un pacchetto IP. Se è presente più di un match, viene considerato quello con il prefisso più lungo.

_nota: i router sono identificati solitamente con un cerchio con dentro una x._

Di seguito è mostrato un esempio di routing:

![routing](../images/routing.png){width=450px}

Sono presenti in totale 7 sottoreti, di cui 3 reti locali e 4 reti punto punto. Tutta la sottorete ha come indirizzo quello raffigurato in alto a sinistra. Gli indirizzi di ciascuna di queste sono come segue:

![routing2](../images/routing_ind.png){width=450px}

Scriviamo la routing table del router identificando le reti direttamente connesse e raggiungibili. Prendiamo come riferimento **R1**:

| Destination    | Next        | Type   |
|----------------|-------------|--------|
| 130.192.3.0/30 | 130.192.3.1 | direct |
| 130.192.3.4/30 | 130.192.3.5 | direct |
| 130.192.2.0/24 | 130.192.2.1 | direct |
| 80.105.10.0/30 | 80.105.10.1 | direct |
| 80.105.10.0/30 | 80.105.10.1 | direct |
| 130.192.0.0/24 | 130.192.3.2 | static |
| 130.192.3.8/30 | 130.192.3.2 | static |
| 130.192.1.6/24 | 130.192.3.2 | static |

<!-- lezione2: -->
## IP addressing methodology

![Rete di esempio](../images/IP_addressing_methodology.png){width=450px}

La metodologia da adoperare è la seguente:

1. Localizzare le reti IP, _in questo caso 3_.
2. Individuare il numero di indirizzi richiesti, _in questo caso nel router in alto a destra è sufficiente `/30` perché ne sono richiesti 4 ($2^2$), `/26` a sinistra ($2^6$) e `/25` in basso a destra ($2^7$)_.
3. Quanti indirizzi posso allocare.
4. Il range di validità degli indirizzi,_in questo caso `/26`, `/25` e `/30` dunque mi basterebbe o tutti e 3, o due `/25` o infine un solo `/24`_
5. netmask / prefix length
6. Address range
7. Host addresses

_Nota: in basso a sinistra sono richiesti 43 indirizzi per 40 dispositivi. Ciò è dovuto al fatto che oltre ai 40 richiesti serve l'indirizzo di rete, l'indirizzo di broadcast e l'indirizzo del router._

Per riuscire a trovare le sottoreti, si prosegue in ordine dal maggiore (decimale minore):

```text
# tutta la rete
10.0.0.0/24

# subnet2 (/25), 32-25 = 7 => 2^7 = 128 indirizzi
# range: 0-127
10.0.0.0/25
10.0.0.127 <- ultimo

# subnet3 (/26), 32-26 = 6 => 2^6 = 64 indirizzi
# range: 128-191
10.0.0.128/26
10.0.0.191 <- ultimo

#subnet4 (/30), punto punto
10.0.0.192/30
```

### Esercizio 1

| Numero di hosts | NetMask           | Prefix Length     | Available Addresses |
|-----------------|-------------------|-------------------|---------------------|
| 2               | `255.255.255.252` | (32-2) -> `/30`   | $2^2 - 2 = 2$       |
| 27              | `255.255.255.224` | (32-5) -> `/27`   | $2^5 - 2 = 30$      |
| 5               | `255.255.255.248` | (32-3) -> `/29`   | $2^3 - 2 = 6$       |
| 100             | `255.255.255.128` | (32-7) -> `/25`   | $2^7 - 2 = 126$     |
| 10              | `255.255.255.240` | (32-4) -> `/28`   | $2^4 - 2 = 14$      |
| 300             | `255.255.254.000` | (32-9)  -> `/23`  | $2^9 - 2 = 510$     |
| 1010            | `255.255.252.000` | (32-10) -> `/22`  | $2^10 - 2 = 1022$   |
| 55              | `255.255.255.192` | (32-6) -> `/26`   | $2^6 - 2 = 62$      |
| 167             | `255.255.255.000` | (32-8) -> `/24`   | $2^8 - 2 = 254$     |
| 1540            | `255.255.248.000` | (32-11)  -> `/21` | $2^11 - 2 = 2046$   |

_Nota: per calcolare la netmask, si esegue $256 - 2^bit$_

### Esercizio 2

> Verifica se i seguenti indirizzi sono  validi o meno.

| IP / Prefix Length pair | Valido?                       |
|-------------------------|-------------------------------|
| `192.168.5.0/24`        | Si, gli ultimi 8bit sono a 0  |
| `192.168.4.23/23`       | No                            |
| `192.168.2.36/30`       | Si, $36 \bmod 2^(32-30) = 0$  |
| `192.168.2.36/29`       | No, $36 \bmod 2^(32-29) != 0$ |
| `192.168.2.32/28`       | Si, $32 \bmod 2^(32-28) = 0$  |
| `192.168.2.32/27`       | Si, $32 \bmod 2^(32-27) = 0$  |
| `192.168.3.0/23`        | No, $3 \bmod 2^(1) != 0$      |
| `192.168.2.0/31`        | No, `/31` non ha senso        |
| `192.168.2.0/23`        | Si, $2\bmod2^(1) != 0$        |
| `192.168.16.0/21`       | Si, $16\bmod2^3 = 0$          |
| `192.168.12.0/21`       | No, $12\bmod2^3 = 0$          |

<!-- lezione3: 2022-10-05 -->
### Esercizio 3

> Trova l'errore di configurazione nella rete indicata di seguito e spiega il motivo per cui questa non funziona come dovrebbe.

![Configurazione](../images/01/01_es3.png){width=450px}  
<!-- todo -->

### Esercizio 4

> Definisci un piano di indirizzamento IP per la rete in figura. Considera entrambi i tipi di indirizzamento: "tradizionale" (senza minimizzare) e una soluzione che minimizzi il numero di indirizzi IP utilizzati. Assumi di utilizzare il range 10.0.0.0/16.

![Rete](../images/01/01_es4.png){width=450px} 

Partiamo evidenziando come il router a sinistra, al fine di servire 350 host, ha in realtà bisogno di 353 indirizzi: 350 host + 1 indirizzo di rete + 1 indirizzo di broadcast + 1 indirizzo del router, dunque `/23`. Stesso ragionamento è applicabile al router di destra, che ha bisogno di 123 indirizzi `/25`.

Troviamo così che `10.0.0.0/23` è la rete A (sinistra). Il suo indirizzo di broadcast sarà `10.0.1.255` in quanto adoperiamo 9 bit (quindi gli ultimi 8 bit a 1 e il primo bit del terzo gruppo a 1).

La sottorete C (destra) sarà identificata da `10.0.2.0/25` in quanto l'indirizzo immediatamente successivo. Il suo indirizzo di broadcast sarà `10.0.2.127`.

La sottorete B (centrale) sarà identificata da `10.0.2.128/30`, con `/30` proveniente dal fatto che è una sottorete punto punto.

Questa soluzione comporta un grosso spreco, in quanto c'è un `/25` che non viene utilizzato.

![Soluzioni](../images/01/01_es4_2.png){width=450px}

### Esercizio 5

> Definisci un albero di routing per tutti i nodi della rete mostrata di seguito.

![Rete esercizio 5](../images/01/01_es5.png){width=150px}

L'**albero di instradamento** è quello che, a partire da un router della rete, stabilisce i percorsi minimi per raggiungere tutti i nodi. Per calcolare l'albero di instradamento si prende un router come riferimento, ad esempio **A**.

| dest | next               |
|------|--------------------|
| B    | 3 (ramo dx)        |
| C    | 2 (ramo inf)       |
| D    | 4 (sia dx che inf) |
| E    | 7 (ramo inf)       |

La stessa procedura dovrà essere poi eseguita per tutti i nodi rimanenti, minimizzando le distanze. A parità di distanza solitamente ci sono motivi differenti per cui si scegli un percorso piuttosto che un altro (es router più nuovi).

![Soluzione esercizio 5](../images/01/01_es5sol.png){width=450px}

### Esercizio 6

> Data la rete mostrata di seguito, definire la routing table di R1. La route aggregation deve essere massimizzata. Gli indirizzi ip mostrati in figura sono relativi all'interfaccia del router più vicino.

![Esercizio 6](../images/01/01_es6.png){width=450px}

Cominciamo scrivendo la routing table di **R1**:

| dest                   | next hop       | Type |
|------------------------|----------------|------|
| `130.192.2.36/30`  (A) | `130.192.2.37` | D    |
| `130.192.2.0/30`   (B) | `130.192.2.1`  | D    |
| `130.192.2.40/30`  (C) | `130.192.2.41` | D    |
| `130.192.1.126/30` (D) | `130.192.2.38` | S    |
| `130.192.0.0/24`   (E) | `130.192.2.38` | S    |
| `130.192.1.128/25` (F) | `130.192.2.38` | S    |
| `130.192.2.32/30`  (G) | `130.192.2.38` | S    |

**D** ed **F** possono essere accorpati con `130.192.1.0/24`, che a sua volta può essere aggregato con e ottenendo l'indirizzo `130.192.0.0/23` avendo il valore di broadcast pari a `130.192.1.255`, per includere anche **G** è possibile usare `130.192.0.0/22`. Dobbiamo però stare attenti a controllare come questi si rapportano con le entry statiche. In questo caso le include tutte, e non è un problema.


### Esercizio 7

> Realizzare un piano di indirizzamento che minimizza il numero di indirizzi necessari.

![Esercizio 7](../images/01/01_es9.png){width=450px}

Troviamo la routing table di **R1**, analizzando ogni nodo a partire dai collegamenti diretti:

- Nella sottorete **A** sono presenti 27 host, per cui sono necessari 27+3 indirizzi e un prefix length di $(32-5) = 27$.
- Nella sottorete **B** sono invece necessari 120+3 indirizzi, per cui un prefix length di $(32-7) = 25$.
- Le sottorete C e D sono invece una sottoreti punto punto, per cui è necessario un prefix length di 30.
- La sottorete E ha bisogno di 60+3 indirizzi, per cui un prefix length di $(32-6) = 26$. Infine la sottorete F ha bisogno di 10+3 indirizzi, per cui un prefix length di $(32-4) = 28$.

Troviamo adesso quali sono gli indirizzi delle sottoreti, partendo da quella di dimensione maggiore (B, in quanto `/25`).

- **B**: `130.192.0.0/25`, con indirizzo di broadcast `130.192.0.127` in quanto gli ultimi 7 bit sono a 1.
- **E**: `130.192.0.128/26` con indirizzo di broadcast `130.192.0.191`
- **A**: `130.192.0.192/27`, con indirizzo di broadcast `130.192.0.223`
- **F**: `130.192.0.224/28`, con indirizzo di broadcast `130.192.0.239`
- **C**: `130.192.0.240/30`, con indirizzo di broadcast `130.192.0.243`
- **C**: `130.192.0.244/30`, con indirizzo di broadcast `130.192.0.247`

E' ora possibile calcolare gli indirizzi dei next hop, prendendo come riferimento il router più vicino:

| dest                   | Gateway         | Type |
|------------------------|-----------------|------|
| `130.192.0.240/30` (C) | `130.192.0.241` | D    |
| `130.192.0.244/30` (D) | `130.192.0.245` | D    |
| `130.192.0.192/27` (A) | `130.192.0.242` | S    |
| `130.192.0.0/25`   (B) | `130.192.0.242` | S    |
| `130.192.0.128/26` (E) | `130.192.0.246` | S    |
| `130.192.0.224/28` (F) | `130.192.0.246` | S    |

Di queste entry bisogna valutare se è possibile fare qualche aggregazione. E' possibile farlo con **E** ed **F** in quanto: avendo `/26` e `28`, possono essere racchiusi in un `/25` (quindi $2^7$) con il medesimo indirizzo di **E** (`130.192.0.128/25` è valido perché 128 % 128 = 0). La soluzione risulta comunque inefficiente perché non abbiamo ottenuto solo una entry.

### Esercizio 8

> Realizzare un piano di indirizzamento che minimizza il numero di indirizzi necessari. Utilizzare il risultato della routing table di R1.

![Esercizio 9](../images/01/01_es8.png){width=450px}
<!-- TODO -->

### Esercizio 9

> Assumendo di avere interamente la cache libera, indicare il numero e il tipo di frames catturati da uno sniffer localizzato nella rete cablata dell'host A.

![Esercizio 10](../images/01/01_es10.png){width=450px}

In una macchina Windows il ping viene eseguito 4 volte.

Bisogna innanzitutto verificare che le due macchine siano effettivamente nella stessa rete, lo si fa vedendo se hanno la stessa sottorete (in questo caso si, entrambi coerenti sulla `130.192.16.0/24`).

Scriviamo ora la tabella:

ID | MACS | MACD      | IPS | IPD | DESCRIZIONE
---|------|-----------|-----|-----|-------------------
1  | MACA | broadcast | -   | -   | ARP Request
2  | MACB | MACA      | -   | -   | ARP Response
3  | MACA | MACB      | IPA | IPB | ICMP echo request
4  | MACB | MACA      | IPB | IPA | ICMP echo response

Il passaggio 3 e 4 sono quelli eseguiti 4 volte.

### Esercizio 10

<!-- lezione4: 2022-10-06 -->

> Assuming that all caches are empty, indicate the number and the type of the frames captured by a sniffer located sulla rete dell'host A.

![Esercizio 10](../images/01/01_es11.png){width=450px}  

L'indirizzo IP del DNS  è in realtà l'indirizzo di un host in quanto l'indirizzo della sottorete, con prefix length pari a `/23` abbiamo `130.192.16.0/23` (osservando il router). Il relativo indirizzo di broadcast viene calcolato sapendo di avere gli ultimi 9 bit a 1, quindi `130.192.17.255`, quindi l'indirizzo fornito è incluso.

La sottorete di A ha indirizzo della sottorete pari a `130.192.16.0`, è errato il prefix length in quanto viene indicato `/24` invece di `/23`.

A quando comunica per parlare con il DNS, che è all'esterno della sua sottorete, parla con il suo default gateway.

ID | MACS   | MACD      | IPS       | IPD       | DESCRIZIONE
---|--------|-----------|-----------|-----------|-------------------
1  | MACA   | broadcast | -         | -         | ARP Request
2  | MACDG  | MACA      | -         | -         | ARP Response
3  | MACA   | MACDG     | IPA       | IPDNS     | DNS request
4  | MACDG  | broadcast | -         | -         | ARP request
5  | MACDNS | MACDG     | -         | -         | ARP response
6  | MACDG  | MACDNS    | IPA       | IPDNS     | DNS request
7  | MACDNS | broadcast | -         | -         | ARP request
8  | MACA   | MACDNS    | -         | -         | ARP response
9  | MACDNS | MACA      | IPDNS     | IPA       | DNS response
10 | MACA   | MACDG     | IPA       | IP google | ICMP echo request
11 | MACDG  | MACA      | IP google | IPA       | ICMP echo response

Essendo uno shared bus tutti i pacchetti sono condivisi, solo che che chi non è interessato ai pacchetti che riceve li scarta. _Nota: DG viene utilizzato per indicare default gateway; arp è di livello 2._ Il traffico viene ottenuto prima che entri nel nodo A.

Il passaggio 10 e 11 sono quelli eseguiti 4 volte.

<!-- TODO -->

## Multicast

Il multicast è un concetto che sta nel mezzo tra una comunicazione unicast (1 a 1) e broadcast (1 a tutti). Una sorgente A manda i pacchetti ad _alcuni_ host. Ci sono dunque dei gruppi a cui degli host possono entrare o uscire. E' vantaggioso in quanto l'alternativa sarebbe mandare pacchetti uno ad uno in modo molto più lento. Nel multicast viene inviato un solo pacchetto, che viene poi instradato correttamente dal router ai destinatari utilizzando meno traffico (nel broadcast è sempre un pacchetto, ma viene poi mandato a tutti appesantendo). In IPv4 viene utilizzato poco perché si ha problemi con l'indirizzamento.

E' ampiamente utilizzato in IPv6 ed è chiave per la comunicazioni tra gruppi (videoconferenze, video broadcast ecc).

![Multicast](../images/01/01_multicast.png){width=450px}

A ogni gruppo multicast viene associato un indirizzo IPv4. Questo indirizzo è un indirizzo di classe D, che è un indirizzo di broadcast. Fanno parte del range `224.0.0.0` - `239.255.255.255` che sono riservati, ed è per questo necessario acquistarne uno per utilizzarlo.

Il protocollo prevede che il livello 2 scarti i pacchetti che non sono di interesse, ma comunque è possibile associare un indirizzo di livello 2 al livello 3 in modo che possa essere scartato successivamente. L'indirizzo MAC è formato da 48 bit, rappresentato in forma compatta da gruppi di 8 bit ognuno dei quali rappresentato da 2 cifre esadecimali. La parte alta, solitamente riservata al produttore, ha invece la costante `01-00-5E-0` che identifica la mappatura per un totale di 25 bit (l'ultimo gruppo è solo un bit). La mappatura è fatta non comprendendo tutti i casi ma cercando di ridurre il numero di collisioni.

![Mappatura IP a MAC](../images/01/01_ip_mac_mapping.png){width=450px}

<!-- fine Capitolo1 -->