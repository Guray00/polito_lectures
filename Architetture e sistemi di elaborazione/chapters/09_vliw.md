# Vliw

L'evoluzione del processori superscalare ha portato a complessi processori composti da più unità funzionali, e tutti sono accomunati da una logica per rilevare e gestire le dipendenze, schedulare dinamicamente, previsione e speculazione su branch. Ciò ha comportato un aumento notevole della complessità dei processori.

Sono stati studiati anche approcci alternativi tra cui i VLIW.

I VLIW (Very Long Instruction Word) sono processori che hanno istruzioni molto lunghe e che hanno encodate molte operazioni, che vengono caricate in parallelo.L'hardware include tante unità operazionali quanto quante sono richieste in una singola istruzione.

Questi processori sono molto diffusi per le  applicazioni embedded.

Ciò ha comportato un software molto più complesso, in quanto è compito del compilatore decidere quali istruzioni impachettare insieme: exploding parallelism, unrolling loops, scheduling code in basic blocks, etc.

Si ha però una semplificazione dell'hardware, in quanto non è necessario effettuare alcun controllo di dipendeze tra le istruzioni e non è dunque necessario avere un'unità che si occupa di valutare quali istruzioni eseguire in parallelo.

Quando una operazione richiede uno stallo, l'intero pacchetto di istruzioni viene posto in pausa in modo da preservare il flusso deciso dal compilatore.

## Limitazioni

Le performance che possono essere causate da un multiple issue processor sono limitate dalla limitazioni dei programmi ILP, difficolta di costruire l'hardware, limitazioni specifiche di processori superscalari o vliw.

E' inoltre difficile trovare un numero sufficiente di istruzioni indipendenti da eseguire in parallelo, soprattutto se consideriamo le unità funzionali pipelined che abbiano una latenza minore di 1.

In generale, per evitare gli stalli sarebbe necessario avere un numero di operazioni indipendenti circa pari a:

$$ \text{avarage pipeline depth} * \text{number of functional units} $$

Con l'incremento di unità funzionali segue un aumento della bandwdth del file register e della memoria. Ciò significa un aumento della complessità hardware e una riduzione delle performance. Alcune soluzioni possibili sono:

- memory interleaving
- multiport memories
- multiple access per clock cycle memories

La dimensione totale del codice è molto maggiore per i processori VLIW a causa di due fattori principali:

- i cicli sono srotolati in modo molto intensivo per aumentare il parallelismo
- emty slots nel encoding delle istruzioni

Spesso le istruzioni sono compresse in memoria e poi espanse quando caricate nel processore.

Un processore VLIW richiede spesso accesso alla memoria, che può essere un bottleneck in quanto la bandwidth è magigore e gli stalli per i miss in cash possono porre in attesa l'intero processore.

Un ulteriore problema è la compatibilità dei binari, che non può essere garantita in quanto ogni cambio di implementazione richiede una ricompilazione. Questo è uno dei principali svantaggi rispetto ai processori superscalari, che possono creare facilmente binari compatibili con processori precedenti. Object code translation o l'emulazione possono essere le soluzioni a questo problema.

## EPIC

l'architettura EPIC (Explicitly Parallel Instruction Computing) fu introdotta nella fine degli anni 90 in alcuni processori HP e Intel, come Itanium. Lo scopo era quello di ottenere dei VLIW con una maggiore flessibilità, ottenedo successo nell'area dei processori high-end.

## Classificazione

Le istruzioni processate in parallelo richiedono tre task principale:

1. controllare le dipendenze tra le istruzioni per raggruppare le istruzioni per l'esecuzione parallela
2. Assegnare le istruzioni alle unità funzionali per inizializzarle insieme