# IPv4 Summary
<!-- lezione1: -->

In ogni sottorete tutti i dispositivi che ne fanno parte avranno lo stesso indirizzo ip.

## Indirizzi speciali

- tutti i bit a 1: indirizzo di broadcast, non può essere assegnato
- `127.x.x.x`: indirizzo di loopback, è una  classe di indirizzi e servono a identificare l'host stesso e per tale motivo vengono solitamente utilizzate a scopo di debug.


Spesso oggi giorno non è consentito l'invio di messaggi in broadcast per motivi di sicurezza.


## Indirizzamento IP con classi

Le rappresentazioni possono essere classes (a classe) o classness (senza l'utilizzo di classi). In particolare esistono di tre tipologie:

- **A**: prevede i primi 8 bit per l'indirizzo di rete, i rimanenti sono per identificare i dispositivi. Il totale degli indirizzi è 2^7 per la rete e 2^24 per i dispositivi. Si possono avere 128 networks.
- **B**: i primi due bit vengono utilizzate per il riconoscimento della classe di tipo B, mentre i rimanenti 14 per la parte network e gli ultimi 16 per gli host. 
- **C**:

**Nota**:I bit di riconoscimento servono per sapere quali bit individuano la rete e quali gli host.

## Indirizzamento senza classi (CIDR)

Il sistema **C**lassless **I**nter**D**omain **R**outing permette di indirizzare la porzione più precisa di indirizzi tra rete e e dispositivi. La porzione di rete è dunque di lunghezza arbitraria. Il formato con cui può essere rappresentato un indirizzo è il seguente: `networkID + prefix length` oppure `netmask`.

Il prefix length, specificato con `/x`, è il numero di bit  di network.

La netmask è identificata da una serie di bit posti a `1` che determinano quali bit identificano la rete, attraverso un and bit a bit.

*Esempio:*

```text
200.23.16.0/23                # prefix length
200.23.16.0 255.255.255.254.0 # netmask
```

L'indirizzo viene espresso attraverso gruppi di 8 bit, rappresentanti in modo decimale puntato (4 gruppi in quanto 32 bit totali). Ogni raggruppamento avrà un valore da 0 a 255.

Non tutti i valori sono permessi possibili, il più piccolo è 252. Questo è dovuto al fatto che abbiamo l'indirizzo dell'intera sottorete e l'indirizzo del inter broadcast che non possono essere adoperati.

Un modo per sapere se un indirizzo è scritto in modo corretto è prendere il prefix length `/x` e controllare che ci l'ultimo numero puntato sia multiplo di 2^(32-x).

*Esempi:*

```text
130.192.1.4/30  =>  4%(2^32-30) = 4%4  = 0 si!
130.192.1.16/30 => 16%(2^32-30) = 16%4 = 0 si!
130.192.1.16/29 => 16%(2^32-29) ![](../images/chapter1/routing.png)  = 16%8 = 0 si!

130.192.1.1/30 => 1%(2^32-30) = 1%4  != 0 no!
130.192.1.1/29 => 1%(2^32-29) = 1%8  != 0 no!
130.192.1.1/28 => 1%(2^32-28) = 1%16 != 0 no!
```

Per il ragionamento di sopra appare evidente che un indirizzo che termina con `.1` non sarà mai un indirizzo corretto, in quanto ritornerà sempre un resto.

## IP routing

La routing table è caratterizzata da due colonne che identificano:

- **destinazione** (indirizzi ip)
- **interfaccia** (eth0...)

Viene cercato un match all'interno della tabella per identificare dove inviare un pacchetto IP. Se è presente più di un match, viene considerato quello con il prefisso più lungo.

*nota: i router sono identificati solitamente con un cerchio con dentro una x.*

Di seguito è mostrato un esempio di routing:

![routing](../images/routing.png){width=500px}

Sono presenti in totale 7 sottoreti, di cui 3 reti locali e 4 reti punto punto. Tutta la sottorete ha come indirizzo quello raffigurato in alto a sinistra. Gli indirizzi di ciascuna di queste sono come segue:

![routing2](../images/routing_ind.png#image){width=500px}

Scriviamo la routing table del router identificando le reti direttamente connesse e raggiungibili. Prendiamo come riferimento **R1**:

| Destination | Next | Connessione |
|---|---|---|
| 130.192.3.0/30 | 130.192.3.1 | diretta |
| 130.192.3.4/30 | 130.192.3.5 | diretta |
| 130.192.2.0/24 | 130.192.2.1 | diretta |
| 80.105.10.0/30 | 80.105.10.1 | diretta |
| 80.105.10.0/30 | 80.105.10.1 | diretta |



<!-- fine Capitolo1 -->