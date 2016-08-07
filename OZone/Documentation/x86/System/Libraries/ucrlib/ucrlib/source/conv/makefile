INC = ..\..\include

all: isize.obj htoa.obj utoa.obj itoa.obj ultoa.obj ltoa.obj ftoa.obj  more

more: atoi.obj strtoi.obj strtof.obj atof.obj itoam.obj ftoam.obj

clean:
	del *.obj
	del *.bak
	

isize.obj:isize.asm $(INC)\conv.a $(INC)\consts.a
	ml /c isize.asm

htoa.obj:htoa.asm $(INC)\conv.a $(INC)\consts.a
	ml /c htoa.asm

utoa.obj:utoa.asm $(INC)\conv.a $(INC)\consts.a
	ml /c utoa.asm

ultoa.obj:ultoa.asm $(INC)\conv.a $(INC)\consts.a
	ml /c ultoa.asm

ltoa.obj:ltoa.asm $(INC)\conv.a $(INC)\consts.a
	ml /c ltoa.asm

itoa.obj:itoa.asm $(INC)\conv.a $(INC)\consts.a
	ml /c itoa.asm

itoam.obj:itoam.asm $(INC)\conv.a $(INC)\memory.a $(INC)\consts.a
	ml /c itoam.asm

atoi.obj:atoi.asm $(INC)\conv.a $(INC)\consts.a
	ml /c atoi.asm

atof.obj:atof.asm $(INC)\conv.a $(INC)\consts.a
	ml /c atof.asm

Strtoi.obj:strtoi.asm $(INC)\conv.a $(INC)\excepts.a $(INC)\consts.a
	ml /c strtoi.asm

Strtof.obj:strtof.asm $(INC)\conv.a $(INC)\excepts.a $(INC)\consts.a
	ml /c strtof.asm

t2fp.obj: t2fp.asm $(INC)\conv.a $(INC)\stdin.a $(INC)\consts.a
        ml /c t2fp.asm

