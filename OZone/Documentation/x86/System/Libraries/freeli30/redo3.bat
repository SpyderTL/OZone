@echo off
echo Splitting .ASX files...
split 386lib1.asx + > $$$.tmp
split 386lib2.asx + >> $$$.tmp
split freelib3.asx  >> $$$.tmp
echo Assembling files...
tasm -m -ml -q -t c_*.asm
if errorlevel 1 goto done
del 386lib.lib
echo Constructing library...
tlib 386lib.lib @$$$.tmp > nul
tlib 386lib.lib,386lib.lst > nul
:done
ctty nul
del c_*.asm
del $$$.tmp
del *.obj
del *.bak
ctty con
