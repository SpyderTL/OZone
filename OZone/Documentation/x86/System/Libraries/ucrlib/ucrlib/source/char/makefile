# CHAR routines makefile.
#
# Randall Hyde
# 11/16/96


INC = ..\..\include
C=..\..\include\consts.a
M=..\..\include\macros.a



all: IsAlNum.obj IsANcs.obj IsANtos.obj IsANstk.obj alphas
alphas: IsAlpha.obj IsALtos.obj IsALstk.obj IsALcs.obj digits
digits: IsDigit.obj IsDigTos.obj IsDigStk.obj IsDigCS.obj lowers
lowers: IsLower.obj IsLowTOS.obj IsLowSTK.obj IsLowCS.obj uppers
uppers: IsUpper.obj IsUpTOS.obj IsUpSTK.obj IsUpCS.obj xdigs
xdigs:  IsXDigit.obj IsXDtos.obj IsXDstk.obj IsXDcs.obj tolows
tolows: ToLower.obj ToLowTOS.obj ToLowSTK.obj ToLowCS.obj toups
toups:  ToUpper.obj	ToUpTOS.obj ToUpSTK.obj ToUpCS.obj


clean:
	del *.obj
	del *.bak
	


IsAlNum.obj: IsAlNum.asm $(INC)\char.a $(C) $(M)
        ml /c IsAlNum.asm

IsANcs.obj: IsANcs.asm $(INC)\char.a $(C) $(M)
        ml /c IsANcs.asm
		
IsANtos.obj: IsANtos.asm $(INC)\char.a $(C) $(M)
        ml /c IsANtos.asm
		
IsANstk.obj: IsANstk.asm $(INC)\char.a $(C) $(M)
        ml /c IsANstk.asm

		

IsAlpha.obj: IsAlpha.asm $(INC)\char.a $(C) $(M) 
        ml /c IsAlpha.asm

IsALtos.obj: IsALtos.asm $(INC)\char.a $(C) $(M) 
        ml /c IsALtos.asm

IsALstk.obj: IsALstk.asm $(INC)\char.a $(C) $(M) 
        ml /c IsALstk.asm

IsALcs.obj: IsALcs.asm $(INC)\char.a $(C) $(M) 
        ml /c IsALcs.asm



IsDigit.obj: IsDigit.asm $(INC)\char.a $(C) $(M) 
        ml /c IsDigit.asm

IsDigTos.obj: IsDigTos.asm $(INC)\char.a $(C) $(M) 
        ml /c IsDigTos.asm

IsDigStk.obj: IsDigStk.asm $(INC)\char.a $(C) $(M) 
        ml /c IsDigStk.asm

IsDigCS.obj: IsDigCS.asm $(INC)\char.a $(C) $(M) 
        ml /c IsDigCS.asm



IsLower.obj: IsLower.asm $(INC)\char.a $(C) $(M) 
        ml /c IsLower.asm

IsLowSTK.obj: IsLowSTK.asm $(INC)\char.a $(C) $(M) 
        ml /c IsLowSTK.asm

IsLowTOS.obj: IsLowTOS.asm $(INC)\char.a $(C) $(M) 
        ml /c IsLowTOS.asm

IsLowCS.obj: IsLowCS.asm $(INC)\char.a $(C) $(M) 
        ml /c IsLowCS.asm




IsUpper.obj: IsUpper.asm $(INC)\char.a $(C) $(M) 
        ml /c IsUpper.asm

IsUpTOS.obj: IsUpTOS.asm $(INC)\char.a $(C) $(M) 
        ml /c IsUpTOS.asm

IsUpSTK.obj: IsUpSTK.asm $(INC)\char.a $(C) $(M) 
        ml /c IsUpSTK.asm

IsUpCS.obj: IsUpCS.asm $(INC)\char.a $(C) $(M) 
        ml /c IsUpCS.asm




IsXDigit.obj: IsXDigit.asm $(INC)\char.a $(C) $(M) 
        ml /c IsXDigit.asm

IsXDtos.obj: IsXDtos.asm $(INC)\char.a $(C) $(M) 
        ml /c IsXDtos.asm

IsXDstk.obj: IsXDstk.asm $(INC)\char.a $(C) $(M) 
        ml /c IsXDstk.asm

IsXDcs.obj: IsXDcs.asm $(INC)\char.a $(C) $(M) 
        ml /c IsXDcs.asm



ToLower.obj: ToLower.asm $(INC)\char.a $(C) $(M) 
        ml /c ToLower.asm

ToLowTOS.obj: ToLowTOS.asm $(INC)\char.a $(C) $(M) 
        ml /c ToLowTOS.asm

ToLowSTK.obj: ToLowSTK.asm $(INC)\char.a $(C) $(M) 
        ml /c ToLowSTK.asm

ToLowCS.obj: ToLowCS.asm $(INC)\char.a $(C) $(M) 
        ml /c ToLowCS.asm




ToUpper.obj: ToUpper.asm $(INC)\char.a $(C) $(M) 
        ml /c ToUpper.asm

ToUpTOS.obj: ToUpTOS.asm $(INC)\char.a $(C) $(M) 
        ml /c ToUpTOS.asm

ToUpSTK.obj: ToUpSTK.asm $(INC)\char.a $(C) $(M) 
        ml /c ToUpSTK.asm

ToUpCS.obj: ToUpCS.asm $(INC)\char.a $(C) $(M) 
        ml /c ToUpCS.asm


