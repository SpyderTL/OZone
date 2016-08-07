@echo off
tasm -m -ml -q -t *.asm
if not exist freelib.lib goto try1
for %%x in (*.obj) do tlink -t %%x,,,freelib.lib
goto done
:try1
if not exist ..\freelib.lib goto error
for %%x in (*.obj) do tlink -t %%x,,,..\freelib.lib
:done
del *.obj
del *.map
goto end
:error
echo Cannot find the library file, FREELIB.LIB in
echo either the current or the parent directory!
echo.
:end
