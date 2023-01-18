# Clocking and Power control functions
<!-- lez30: -->

<!-- mancano slide fino a 14 -->

## Power control registers

Il **PCON** è un registro di controllo che consente di entrare nelle modalità di funzionamento energetico. 

Il **PCONP** è il registro relativo all'alimentazione periferica, utile nel caso si voglia utilizzare il timer 2 e 3.

L'ingresso in modalità di consumo energetico ridotto inizia sempre con l'esecuzione di una WFI (wait for interrupt) o WFE (wait for Exception). Il cortex M3 supporta internamente due modalità di risparmio energetico: sleep e deep sleep. Invece, il power-down e il deep power-down sono selezionati dai bit del registro PCON.

Il registro PCON si occupa anche di gestire alcune modalità di risparmio energetico e altri controlli relativi all'alimentazione. Allo stesso modo, sono presenti dei flag che indicano quando si entra in una situazioone di risparmio energetico.

Il bt PM1 e PM0 di PCON permettono di seleziona una modalità di risparmio energetico. Questi sono encodati in modo da garantire una compatibilità con i dispositivi precedenti che non suppportavano sleep e power-down modes.

### Sleep mode

Quando la **sleep mode** è attivata, il clock del core viene fermato e il **SMFLAG** bit in PCON viene settato. L'esecuzione delle istruzioni viene fermata fino a quando no avviene un reset o una interruzione (il wake up occore quando qualsiasi interruzione occorre).

Le funzioni periferiche continuano a funzionare e potrebbero generare interruzioni che potrebbero risvegliare l'esecuzione. LO sleep mode elminia il dynamic power utilizzato dallo stesso processore, la memoria e il relativi controlli oltre ai bus interni.

### Deep sleep mode

Quando il chip entra in **deep sleep mode**, il clock del core viene fermato interrompendo l'osccilatore principale e il **DSFLAG** bit in PCON viene settato. L'IRC continua a eseguie e può essere configurato per guidare il watchdog timer, permettendo il watchdog di svegliare la cpu.

L'oscillatore a 32 kHz RTC oscillator non è fermato e il RTC potrebbe essere utilizzato come sorgente di risveglio mediante interruzione. 

I PLL sono automaticamente spenti e disconnessi (CCLK e USBCLK vengono resettati a zero).

La memoria FLASH è lasciata in standby in modo da consentire un risveglio rapido.

Dal momento che tutte le operazioni dinamiche sui chip sono sospese, la deep sleep mode riduce il consume energetico dei chip a un valore molto basso. Lo stato del processore e i registri, i registri periferici e la SRAM interna sono preservati e i livelli logici dei pin rimangono statici.

Il deep sleep mode può essere terminato da un reset o da una specifica interruzione in grado di funzionare senza l'utiizzo di clock _(Wake-up from Deep Sleep mode can be brought about by NMI or External Interrupts EINT0 through EINT3)_.

### Power-down mode and Deep Power-down 

In power down mode avvengono le stesse cose del deep sleep mode ma con la differenza che anche la memoria flash viene posta spenta. Questo consente di risparmiare maggiore energia, ma richiede un tempo di attesa maggiore per il rispeglio della memoria prima dell'esecuzione del codice o dell'acceso ai dati. L'ingresso in questo stato causa il set del bit PDFLAG in PCON.

In deep power-down mode  l'alimentazione viene completamente spenta per il cheap ad esclusione del real-time clock, il reset pin, il WIC, il registro di backup RTC. L'ingresso causa il set del bit di **DPDFLAG** in **PCON**.

## Peripheral power control

Il power control periferico è gestito dal registro **PCONP**. Questo consente di spegnere singolarmente le periferiche che non sono necessarie per il funzionamento dell'applicazione, incrementando il risparmio energetico.

Questo risultato viene ottenuto spegnendo la sorgente del clock per determinate periferiche. Alcune funzioni periferiche non possono essere spenti (watchdog timer, il pin connect block, system control block)