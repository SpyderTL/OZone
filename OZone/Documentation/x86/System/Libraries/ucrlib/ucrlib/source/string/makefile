INC = ..\..\include

all: strlen.obj strdup.obj strupr.obj struprm.obj
	
clean:
	del *.obj
	del *.bak

strlen.obj: strlen.asm $(INC)\strings.a $(INC)\consts.a
        ml /c strlen.asm

strupr.obj: strupr.asm $(INC)\strings.a $(INC)\consts.a
        ml /c strupr.asm

struprm.obj: struprm.asm $(INC)\strings.a $(INC)\consts.a
        ml /c struprm.asm

strdup.obj: strdup.asm $(INC)\strings.a $(INC)\memory.a $(INC)\consts.a
        ml /c strdup.asm

