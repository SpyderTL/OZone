INC = ..\..\include

all: argv.obj argc.obj getenv.obj random.obj Intelhex.obj cpuid.obj 

clean:
	del *.obj
	del *.bak	

argv.obj: argv.asm $(INC)\memory.a $(INC)\consts.a $(INC)\misc.a
        ml /c argv.asm

argc.obj: argc.asm $(INC)\memory.a $(INC)\consts.a $(INC)\misc.a
        ml /c argc.asm

getenv.obj: getenv.asm $(INC)\memory.a $(INC)\consts.a $(INC)\misc.a $(INC)\strings.a
        ml /c getenv.asm

random.obj: random.asm $(INC)\misc.a $(INC)\consts.a
        ml /c random.asm

Intelhex.obj: Intelhex.asm $(INC)\misc.a $(INC)\memory.a $(INC)\consts.a
        ml /c Intelhex.asm

CPUID.obj: CPUID.asm $(INC)\misc.a $(INC)\consts.a
        ml /c CPUID.asm

