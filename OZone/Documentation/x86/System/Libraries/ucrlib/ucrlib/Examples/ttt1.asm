; TIC-TAC-TOE
; (TTT.ASM)
;
; An implementation of the Tic-Tac-Toe game in assembly language.
;
; Implementation #1: using boolean logic to indicate the moves to make.
;
; Uses the UCR Standard Library v2.0 for 80x86 assembly language programmers.
;
; Randall Hyde
;
; 8/16/96


		.xlist
                include         ucrlib.a
                includelib      ucrlib.lib
		.list


TTT		struct
X		word	0
O		word	0
TTT		ends



dseg		segment	para public 'data'

GameBoard	TTT	{}


PlayerTkn	byte	'X'
CompTkn	byte	'O'


; Board masks-  Index into this array maps a board position to
;		a bit mask for selecting the corresponding
;		bit for that board position.
;
; Note: the player positions are organized as follows:
;
;   0 | 1 | 2 
;  ---+---+---
;   3 | 4 | 5  
;  ---+---+---
;   6 | 7 | 8  
;
;	 the bitmap is organized as follows:
;
;   0 | 1 | 2 
;  ---+---+---
;   7 | 8 | 3  
;  ---+---+---
;   6 | 5 | 4  

; Typical bit maps used in the game.
		
UpperLeft	=	1
MiddleSquare	=	100000000b



TTTMask	word	UpperLeft, 10b, 100b
		word	10000000b, MiddleSquare, 1000b
		word	1000000b, 100000b, 10000b




OChkThis	word	006h, 0c0h, 110h, 005h, 120h
MaxOs		=	$-OChkThis

OAgainstThis	word	006h, 0c0h, 110h, 005h, 120h

OMoveHere	word	001h, 001h, 001h, 002h, 002h




XChkThis	word	006h, 0c0h, 110h, 005h, 120h, 1FFh, 0C7h,
			0C7h, 0C7h, 122h, 111h
MaxXs		=	$-XChkThis
					    
XAgainstThis	word	006h, 0c0h, 110h, 005h, 120h, 044h, 082h,
			084h, 044h, 100h, 100h

XMoveHere	word	001h, 001h, 001h, 002h, 002h, 002h, 001h,
			001h, 001h, 002h, 001h
dseg		ends



cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg


; DispTTT-
;
; Displays the game board and a map showing the user all
; possible moves they can make.  This function displays
; information like the following:
;
;     |   |       X | X | O 
;  ---+---+---   ---+---+---
;     |   | 5     O | O |   
;  ---+---+---   ---+---+---
;     | 7 | 8     X |   |   
;
; The right-hand board shows the current moves, the left-hand
; board lists the possible player moves.
;
; PutSquare-	Outputs a Blank, "X", or "Y" depending upon whether
;		the current cell is unoccupied, contains a player's
;		token, or the computer's token.
;
; PSNum-	Outputs a single digit in the range 0..8 to denote
;		the key the user should press to select a give cell.
;		PSNum only outputs the digit if this is a possible
;		move for the play (i.e., the cell is current unoccupied).
;		It outputs a blank to the cell if a move is not possible.
;
; DispTTT-	Calls the above two routines to display the tic-tac-toe
;		board.



PutSquare	textequ	<call _PutSquare>
_PutSquare	proc	near

		putc	' '
		mov	al, PlayerTkn	;Determine if this cell is
		mov	dx, GameBoard.X	; occupied by the Player.
		test	dx, TTTMask[si]
		jnz	Occupied

		mov	al, CompTkn	;If not, determine if this cell is
		mov	dx, GameBoard.O	; occupied by the computer's piece.
		test	dx, TTTMask[si]
		jnz	Occupied

		mov	al, ' '		;Must be blank!
Occupied:	putc

		putc	" "
		add	si, 2
		ret
_PutSquare	endp



; PSNum-	Outputs a digit to a TTT cell if that position is
;		unoccupied, outputs a blank to a cell if that position
;		is occupied and the user cannot move there.

PSNum		textequ	<call _PSNum>
_PSNum		proc	near

		putc	" "
		mov	ax, GameBoard.X	;Determine if this cell is
		or	ax, GameBoard.O	; unoccupied (corresponding bits in
		and	ax, TTTMask[si]	; dx and di must both be zero).
		mov	al, ' '		;Assume this cell is occupied.
		jnz	putSp

; The current cell is unoccupied.  Put a digit in it to identify this move
; for the user.

		mov	ax, si		;SI = cell # * 2.  Divide by
		shr	ax, 1 		; two and convert to a digit.
		or	al, '0'

PutSp:		putc
		putc	' '
		add	si, 2
		ret
_PSNum		endp




; Print the TTT board and the possible moves board.

DispTTT	textequ	<call _DispTTT>
_DispTTT	proc	near
		push	ax
		push	dx
		push	si

		mov	si, 0

		putcr
		jmp	PrtTTT

; Each execution of the following loop prints one row on the game board
; and one row on the possible moves board.

PrtLoop:	print	"---+---+---  ---+---+---",nl
PrtTTT:	PSNum		;Display possible moves.
		putc	"|"
		PSNum
		putc	"|"
		PSNum
		sub	si, 6	;Restore SI's value.

		print	"  "
		         
		PutSquare	;Display computer and player's
		putc	"|"	; moves thus far.
		PutSquare
		putc	"|"
		PutSquare
		putcr
		cmp	si, 18
		jb	PrtLoop

		pop	si
		pop	dx
		pop	ax
		ret
_DispTTT	endp

		
		

; GetMove-	Reads (and verifies) a user move.

GetMove	textequ	<call _GetMove>
_GetMove	proc
		push	ax
		push	bx

		print	"Your move:"
		jmp	RptInput

BadInput:	putc	Bell
RptInput:	rawgetc			;Read a single character
		putc			; (unbuffered) and check to see
		tolower			; if the user wants to quit.
		cmp	al, 'q'
		je	QuitGame
		sub	al, '0'		;Check for a digit.  Anything else
		cmp	al, 9		; is an error.
		jae	BadInput

		mov	bl, al		;Check to see if this
		mov	bh, 0		; location on the board
		shl	bx, 1		; is already occupied.
		mov	ax, GameBoard.X
		or	ax, GameBoard.O
		test	ax, TTTMask[bx]
		jnz	BadInput

		mov	ax, TTTMask[bx]	;Make the player's move.
		or	GameBoard.X, ax

		pop	bx
		pop	ax
		ret

QuitGame:	ExitPgm
_GetMove	endp
		
		
		
		
; CmpMove-	Logic to implement the computer's move.
;		Note: the TTT game board is symmetrical, therefore
;		this logic only checks to see if it should move in the
;		Upper Left Hand corner or the cell immediately to the
;		left of the upper left hand corner.  To test all the
;		other positions, this function simply rotates the
;		board 90 degrees and tries again.
;

OTry4		textequ	<call _OTry4>
_OTry4		proc	near
		mov	cx, OMoveHere[si]
t4Lp:		mov	ax, bx
		and	ax, OChkThis[si]
		cmp	ax, OAgainstThis[si]
		jne	tryNext
		test	cl, dl
		jz	Done

tryNext:	ror	bl, 2
		shl	cl, 2
		jnz	t4Lp
		cmp	cl, 1

Done:		ret
_OTry4		endp



XTry4		textequ	<call _XTry4>
_XTry4		proc	near
		mov	cx, OMoveHere[si]
t4Lp:		mov	ax, bx
		and	ax, XChkThis[si]
		cmp	ax, XAgainstThis[si]
		jne	tryNext
		test	cl, dl
		jz	Done

tryNext:	ror	bl, 2
		shl	cl, 2
		jnz	t4Lp
		cmp	cl, 1

Done:		ret
_XTry4		endp





CmpMove	textequ	<call _CmpMove>
_CmpMove	proc	near


; Strategy #1- See if we can win on the next move.

		mov	si, 0
ChkOs:		mov	bx, GameBoard.O
		mov	dx, bx
		or	dx, GameBoard.X
		OTry4
		jz	WinCL
		add	si, 2
		cmp	si, MaxOs
		jb	ChkOs



; Strategy #2- See if we need to block X.

		mov	si, 0
ChkXs:		mov	bx, GameBoard.X
		mov	dx, bx
		or	dx, GameBoard.O
		XTry4
		jz	MoveCL
		add	si, 2
		cmp	si, MaxXs
		jb	ChkXs




; Strategy #5: Find the first available empty cell and move there.

XsDone:	mov	cl, 1
		mov	bx, GameBoard.O
		or	bx, GameBoard.X
FindEmpty:	shr	bx, 1
		jnc	MoveCL
		shl	cl, 1
		jnz	FindEmpty

; If we hit this point, the game is over because the board is full.

		stc
		ret

; WinCL-	The CL register contains the winning move.

WinCL:		or	byte ptr GameBoard.O, cl
		stc
		ret

; MoveCL-	The CL register contains the computer's move, but
;		the computer hasn't won yet.

MoveCL:	or	byte ptr GameBoard.O, cl
		clc
		ret
_CmpMove	endp







						

Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax

; Do the first move manually.
; If the user chooses the middle cell, pick the upper left hand
; cell.  Otherwise pick the middle cell.

		DispTTT
		GetMove
		test	GameBoard.X, MiddleSquare	;Middle Square?
		jz	MoveMiddle
		mov	GameBoard.O, UpperLeft	;Upper left corner.
		jmp	NextMove

MoveMiddle:	mov	GameBoard.O, MiddleSquare


; Okay, after the first move we need to get smart...

NextMove:	DispTTT
		GetMove
		mov	ax, GameBoard.X	;See if the gameboard is
		or	ax, GameBoard.O	; full (game over).
		cmp	ax, 111111111b
		je	GameOver

		CmpMove
		jnc	NextMove		;Carry set if game over.

GameOver:	DispTTT
		print	nl,"Game Over",nl
Quit:		ExitPgm			;DOS macro to quit program.
Main		endp

cseg            ends

sseg		segment	para stack 'stack'
stk             db      16384 dup (?)
sseg		ends


zzzzzzseg	segment	para public 'zzzzzz'
LastBytes	db	16 dup (?)
zzzzzzseg	ends
		end	Main
