# Possesso

In rust ogni valore introdotto nel programma è posseduto da una ed una sola variabile.

Lo scope è associato a un tratto specifico denominato `Drop` che viene eseguito quando la variabile esce dallo scope. Tale funzione va a chiamare la pulizia dell'heap.

```rust
fn main() {
	let s = "hello"; // s è in scope
	println!("{}", s);
} // s esce da scope e viene rilasciato
```

Possedere un valore significa essere responsabile del suo rilascio, liberando la memoria allocata se contiene una risorsa.

Quando avviene una assegnazione si prende i dati della sorgente e li diamo alla destinazione in modo che la sorgente non li possieda più. Questo ha due conseguenze:

- **efficiente** in termini di tempo di esecuzione
- il primo diventi **vuoto** 

E' responsabilità del programmatore eseguire i controlli e non del compilatore.

## Movimento


Gli accessi in lettura alla variabile origineranno deglli errori di compilazioni, in quanto stiamo provando a leggere qualcosa che probabilmente non è ciò chei ci aspettiamo. Gli accessi in scritture sulla variabile originale avranno successo e ne riabiliteranno la lettura.

Un esempio è il codice seguente:

```rust
let mut s1 = “hello”.to_string();
println!(“s1: {}”, s1);  
   
let s2 = s1;
println!(“s2: {}”, s2);
//s1 non è più accessibile
```

:::note
Ma il movimento viene per tutto?
:::

il movimento di un parametro è **definitivo**, l'unico modo per evitarlo è ritornare qualcosa in modo da evitarlo, ma solitamente non serve.

## Copia

Alcuni tipi, tra cui quelli numerici, sono definiti copiabili attraverso l'implementazione del tratto `Copy`. Quando un valore viene assegnato a un'altra vaiabile o suato come arogmento in una funzione, il valore originale rimane accessibile in lettura. questo è possibile quando il valore contenuto non costituisce una risorsa che richiede ulteriori azioni di rilascio.

## Clonazione

I tipi che implementano il tratto `Clone` possono essere duplicati invocando il metodo `clone()` che, a differenza della copia e del movimento, comporta una copia in profondità dei valori. Di conseguenza il costo di tale operazione può essere molto elevato.

## Comparazione con C e C++

In C l'operazione di base è la copia, mentre il moviemento è una opzione (contrariamente al Rust).

## Riferimenti

I riferimenti sono zone di memoria