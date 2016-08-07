INC = ..\..\include

all: excepts.obj excepts2.obj process.obj coroutn.obj

clean:
	del *.obj
	del *.bak	

excepts.obj:excepts.asm $(INC)\excepts.a $(INC)\consts.a
	ml /c excepts.asm

excepts2.obj:excepts2.asm $(INC)\excepts.a $(INC)\consts.a
	ml /c excepts2.asm

process.obj: process.asm $(INC)\excepts.a $(INC)\process.a $(INC)\consts.a
        ml /c Process.asm

coroutn.obj: coroutn.asm $(INC)\process.a $(INC)\consts.a
        ml /c Coroutn.asm

