@echo off
echo Splitting .ASX files...
split freelib1.asx + > $$$.tmp
split freelib2.asx + >> $$$.tmp
split freelib3.asx   >> $$$.tmp
echo Assembling files...
tasm -m -ml -q -t c_*.asm
if errorlevel 1 goto done
del freelib.lib
echo Constructing library...
tlib freelib.lib @$$$.tmp > nul
tlib freelib.lib,freelib.lst > nul
:done
ctty nul
del c_*.asm
del $$$.tmp
del *.obj
del *.bak
ctty con
