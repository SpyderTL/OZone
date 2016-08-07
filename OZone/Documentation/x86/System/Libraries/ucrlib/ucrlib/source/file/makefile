INC = ..\..\include
all: fopen.obj fcreate.obj fclose.obj fread.obj feof.obj fgetc.obj fgets.obj more

more: fgetf.obj fgeti.obj fgetsm.obj fputc.obj fputl.obj fputi.obj fputu.obj more2

more2: fwrite.obj fputf.obj fputs.obj

clean:
	del *.obj
	del *.bak

	

fopen.obj: fopen.asm $(INC)\file.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fopen.asm

fclose.obj: fclose.asm $(INC)\file.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fclose.asm

fread.obj: fread.asm $(INC)\file.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fread.asm

fEOF.obj: fEOF.asm $(INC)\file.a $(INC)\consts.a
        ml /c fEOF.asm

fgetc.obj: fgetc.asm $(INC)\file.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fgetc.asm

Fgets.obj: fgets.asm $(INC)\file.a  $(INC)\excepts.a $(INC)\macros.a
        ml /c fgets.asm

Fgetf.obj: fgetf.asm $(INC)\file.a $(INC)\stdin.a $(INC)\conv.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fgetf.asm

Fgeti.obj: fgeti.asm $(INC)\file.a $(INC)\stdin.a $(INC)\conv.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fgeti.asm

Fgetsm.obj: fgetsm.asm $(INC)\file.a $(INC)\stdin.a $(INC)\conv.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fgetsm.asm

Fputc.obj: fputc.asm $(INC)\file.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fputc.asm

Fputi.obj: fputi.asm $(INC)\file.a $(INC)\excepts.a $(INC)\conv.a $(INC)\consts.a
        ml /c fputi.asm

Fputu.obj: fputu.asm $(INC)\file.a $(INC)\excepts.a $(INC)\conv.a $(INC)\consts.a
        ml /c fputu.asm

Fputl.obj: fputl.asm $(INC)\file.a $(INC)\excepts.a $(INC)\conv.a $(INC)\consts.a
        ml /c fputl.asm

Fwrite.obj: fwrite.asm $(INC)\file.a $(INC)\excepts.a $(INC)\consts.a
        ml /c fwrite.asm

Fputf.obj: fputf.asm $(INC)\file.a $(INC)\conv.a $(INC)\consts.a
        ml /c fputf.asm

Fputs.obj: fputs.asm $(INC)\file.a $(INC)\consts.a
        ml /c fputs.asm


