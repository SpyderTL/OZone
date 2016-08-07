INC = ..\..\include

all: puti.obj putc.obj printf.obj puth.obj putu.obj putl.obj puts.obj more

more: putf.obj printff.obj

clean:
	del *.obj
	del *.bak	

puti.obj: puti.asm putl.asm $(INC)\stdout.a $(INC)\consts.a
        ml /c puti.asm

putu.obj: putu.asm putl.asm $(INC)\stdout.a $(INC)\consts.a
        ml /c putu.asm

putl.obj: putl.asm $(INC)\conv.a $(INC)\stdout.a $(INC)\consts.a
        ml /c putl.asm

putc.obj: putc.asm $(INC)\stdout.a $(INC)\consts.a
        ml /c putc.asm

puts.obj: puts.asm $(INC)\stdout.a $(INC)\consts.a
        ml /c puts.asm

putf.obj: putf.asm $(INC)\stdout.a  $(INC)\consts.a
        ml /c putf.asm

printf.obj:printf.asm  $(INC)\conv.a $(INC)\stdout.a $(INC)\consts.a
        ml /c printf.asm

printff.obj:printff.asm  $(INC)\conv.a $(INC)\stdout.a $(INC)\consts.a
        ml /c printff.asm

puth.obj:puth.asm $(INC)\conv.a $(INC)\stdout.a $(INC)\consts.a
	ml /c puth.asm

