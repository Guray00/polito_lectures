@ECHO OFF

cd ".\Tecnologie e Servizi di Rete" & call .\compile.bat & cd ".."

echo: 
echo ========================================================================
echo: 

cd ".\Architetture e sistemi di elaborazione" & call .\compile.bat & cd ".."

echo: 
echo ========================================================================
echo: 

cd ".\Information Systems" & call .\compile.bat & cd ".."
