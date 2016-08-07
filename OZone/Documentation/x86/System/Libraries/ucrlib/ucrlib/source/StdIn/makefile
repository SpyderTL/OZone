INC = ../../include

all: rawgetc.obj rawgets.obj rawgtsm.obj getc.obj gets.obj getsm.obj tstKbd.obj more

more: geti.obj getf.obj t2fp.obj scanf.obj scanff.obj

	
clean:
	del *.obj
	del *.bak

rawgetc.obj: rawgetc.asm $(INC)\stdin.a $(INC)\excepts.a $(INC)\consts.a
        ml /c rawgetc.asm

rawgets.obj: rawgets.asm $(INC)\stdin.a $(INC)\excepts.a $(INC)\consts.a
        ml /c rawgets.asm

rawgtsm.obj: rawgtsm.asm $(INC)\stdin.a $(INC)\consts.a
        ml /c rawgtsm.asm

getc.obj: getc.asm $(INC)\stdin.a $(INC)\consts.a
        ml /c getc.asm

gets.obj: gets.asm $(INC)\stdin.a $(INC)\consts.a
        ml /c gets.asm

getsm.obj: getsm.asm $(INC)\stdin.a $(INC)\consts.a
        ml /c getsm.asm

geti.obj: geti.asm $(INC)\stdin.a $(INC)\consts.a $(INC)\excepts.a
        ml /c geti.asm

getf.obj: getf.asm $(INC)\stdin.a $(INC)\consts.a $(INC)\excepts.a
        ml /c getf.asm

t2fp.obj: t2fp.asm $(INC)\conv.a $(INC)\stdin.a $(INC)\consts.a
        ml /c t2fp.asm

tstKbd.obj: tstKbd.asm $(INC)\stdin.a $(INC)\consts.a
        ml /c tstKbd.asm

scanf.obj: scanf.asm $(INC)\strings.a $(INC)\consts.a $(INC)\stdin.a $(INC)\stdout.a
        ml /c scanf.asm

scanff.obj: scanff.asm $(INC)\strings.a $(INC)\consts.a $(INC)\stdin.a $(INC)\stdout.a
        ml /c scanff.asm

