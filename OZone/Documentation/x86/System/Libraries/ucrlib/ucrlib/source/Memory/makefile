INC = ..\..\include
all: memory.obj memutils.obj realloc.obj meminit2.obj
	
clean: 
	del *.obj
	del *.bak


memory.obj:memory.asm $(INC)\memory.a $(INC)\excepts.a $(INC)\consts.a
	ml /c memory.asm

memutils.obj:memutils.asm $(INC)\memory.a $(INC)\excepts.a $(INC)\consts.a
	ml /c memutils.asm

meminit2.obj:meminit2.asm $(INC)\memory.a $(INC)\excepts.a $(INC)\consts.a
	ml /c meminit2.asm

realloc.obj:realloc.asm $(INC)\memory.a $(INC)\excepts.a $(INC)\consts.a
	ml /c realloc.asm

