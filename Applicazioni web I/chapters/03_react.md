# React

React è un framework che ha come scopo quello di semplificare la creazione di interfacce grafiche. React è stato creato da Facebook e viene utilizzato per la creazione di applicazioni web, mobile e desktop.

I motivi per cui questo è utilizzato sono legati a una maggiore semplificazione dell'ambiente del browser:

- I metodi del DOM sono uniformati
- La gerarchia è più esplicita
- I componenti vengono gestiti a più alto livello
- Viene automatizzato il processo di gestione degli eventi e degli aggiornamenti.

Inoltre viene semplificato la metodologia di sviluppo:

- Vengono utilizzati pattern di programmazione predefiniti e architetture di applicazioni
- Utilizzati molto plugin compatibili ed estensioni
- Gestione esplicita e rigida

## Concetti chiave

Il funzionamento di react si basa su un approccio di tipo dichiarativo, senza mai manipolare esplicitamente il DOM, bensì limitandosi a specificare come ciascun componente deve comportarsi.

Inoltre, viene utilizzato un approccio di tipo funzionale: i componenti sono utilizzati come delle funzioni e il DOM viene renderizzato a ogni cambiamento (virtual DOM). La gestione dello stato dell'applicazione è gestita esplicitamente.

Per generare un componente UI è sufficiente porre:

```text
UI fragment = f(state, props)
```

Molti componenti non necessitano di manipolare lo stato, rendendo l'oggetto immutabile ed idenpotente.

```text
UI fragment = f(props)
```

:::tip
Con `props` si intende la proprietà del componente, mentre con `state` lo stato del componente.
:::
