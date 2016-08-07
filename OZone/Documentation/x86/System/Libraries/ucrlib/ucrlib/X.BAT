cd source
nmake
if errorlevel 1 goto done
cd ..
ml ex.asm
if errorlevel 1 goto done
ex

:done
cd \ucrlib