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


TTTMask	word	UpperLeft, 10b, 100b
		word	10000000b, MiddleSquare, 1000b
		word	1000000b, 100000b, 10000b


; Typical bit maps used in the game.
		
UpperLeft	=	1
MiddleSquare	=	100000000b
Row1Chk	=	110b
Row1aChk	=	101b
Col1Chk	=	11000000b
Col2Chk	=	100100000b
Diag1Chk	=	100010000b

StrategicBM	=	11000111b
Sneaky1	=	10000010b
Sneaky2	=	10000100b
Sneaky3	=	01000100b


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
;
;
; Chk2ul-	Checks to see if filling the upper left hand corner
;		would create three Os in a row or block three Xs in a row.
;
;		On Entry, BX contains the bit map we want to check.
;		Returns zero flag set if we need to move in the
;		upper left hand corner.
;
;		DX contains a bit map of all the moves made thus far.
;		CL contains the actual bit position we are trying to
;		move into.


Chk2ul		textequ	<call _Chk2ul>
_Chk2ul	proc	near
		test	cl, dl		;Don't bother checking
		jnz	MustMove		; if cell is occupied.

		mov	al, bl		;Checks:    | * | *
		and	al, Row1Chk	;        ---+---+---
		cmp	al, Row1Chk	;	   |   |
		je	MustMove		;        ---+---+---
					;	   |   |


		mov	al, bl	  	;Checks:    |   |  
		and	al, Col1Chk	;        ---+---+---
		cmp	al, Col1Chk	;	 * |   |
		je	MustMove	  	;        ---+---+---
				  	;	 * |   |


		mov	ax, bx		;Checks:    |   |  
		and	ax, Diag1Chk	;        ---+---+---
		cmp	ax, Diag1Chk	;	   | * |
MustMove:	ret			;        ---+---+---
_Chk2ul	endp			;	   |   |	*
		




; Chk2Top-	Checks to see if filling cell #1 would create three
;		Os in a row or block three Xs in a row.

Chk2Top	textequ	<call _Chk2Top>
_Chk2Top	proc	near
		test	cl, dl		;Don't bother checking
		jnz	MustMove		; if cell is occupied.


		mov	al, bl		;Checks:  * |   | *
		and	al, Row1aChk	;        ---+---+---
		cmp	al, Row1aChk	;	   |   |
		je	MustMove		;        ---+---+---
					;	   |   |

		mov	al, bl	  	;Checks:    |   |  
		and	ax, Col2Chk	;        ---+---+---
		cmp	ax, Col2Chk	;	   | * |
MustMove:	ret		  	;        ---+---+---
_Chk2Top	endp		  	;	   | * |



; Strategic-	Checks one move ahead to see if we need to block
;		X because the player is getting sneaky.
;
;		On entry, BX contains the bitmap to test.
;
; Here are the positions we must block:
;
;    | * |        |   | *      | * |  
; ---+---+---  ---+---+---  ---+---+---
;    | @ | @    * | @ | @    * | @ | @
; ---+---+---  ---+---+---  ---+---+---
;  * | @ | @      | @ | @      | @ | @

Strategic	textequ	<call _Strategic>
_Strategic	proc	near
		test	cl, dl		;Don't bother checking
		jnz	MustMove		; if cell is occupied.

		mov	ax, bx
		and	ax, StrategicBM
		cmp	ax, Sneaky1
		je	MustMove
		cmp	ax, Sneaky2
		je	MustMove
		cmp	ax, Sneaky3
MustMove:	ret
_Strategic	endp



; ForceBlkul-	Look for a move that will force the player to block
; ForceBlkTop-	the computer on the next move.
;
;    | @ | @    @ |   | @ 
; ---+---+---  ---+---+---
;  @ | O | @    @ | O | @ 
; ---+---+---  ---+---+---
;  @ | @ |      @ |   | @ 


ForceBlkul	textequ	<call _ForceBlkul>
_ForceBlkul	proc	near
		test	cl, dl		;Don't bother checking
		jnz	CantMove		; if cell is occupied.

		mov	ax, bx
		and	ax, 100010001b
		cmp	ax, 100000000b
CantMove:	ret
_ForceBlkul	endp



ForceBlkTop	textequ	<call _ForceBlkTop>
_ForceBlkTop	proc	near
		test	cl, dl		;Don't bother checking
		jnz	CantMove		; if cell is occupied.

		mov	ax, bx
		and	ax, 100100010b
		cmp	ax, 100000000b
CantMove:	ret
_ForceBlkTop	endp





CmpMove	textequ	<call _CmpMove>
_CmpMove	proc	near


; Strategy #1- See if we can win on the next move.

		mov	cl, 1
		mov	bx, GameBoard.O
		mov	dx, GameBoard.O
		or	dx, GameBoard.X
ChkAllula:	Chk2ul
		jz	WinCL
		ror	bl, 2
		shl	cl, 2
		jnz	ChkAllula

		mov	cl, 10b
		mov	bx, GameBoard.O
ChkAllTopa:	Chk2Top
		jz	WinCL
		ror	bl, 2
		shl	cl, 2
		jnz	ChkAllTopa

; Strategy #2-	See if we need to block X on the next move.

		mov	cl, 1
		mov	bx, GameBoard.X
ChkAllulb:	Chk2ul
		jz	MakeMoveCL
		ror	bl, 2
		shl	cl, 2
		jnz	ChkAllulb

		mov	cl, 10b
		mov	bx, GameBoard.X
ChkAllTopb:	Chk2Top
		jz	MakeMoveCL
		ror	bl, 2
		shl	cl, 2
		jnz	ChkAllTopb


; Strategy #3a: See if we need to block X one move ahead of the game.
;
; Special cases:
;
;     |   | *    * |   |   
;  ---+---+---  ---+---+---
;     | @ |        | @ |   
;  ---+---+---  ---+---+---
;   * |   |        |   | * 

		mov	cl, 2
		cmp	byte ptr GameBoard.X, 00010001b
		je	MakeMoveCL


		mov	cl, 80h
		cmp	byte ptr GameBoard.X, 01000100b
		je	MakeMoveCL


; Strategy #3b: See if we need to block X one move ahead of the game.

		mov	cl, 1
		mov	bx, GameBoard.X
ChkBlock:	Strategic
		jz	MakeMoveCL
		ror	bl, 2
		shl	cl, 2
		jnz	ChkBlock

; Strategy #4:	Locate a move that will force X to block the computer
;		from winning.

		mov	cl, 2
		mov	bx, GameBoard.O
ChkForceTop:	ForceBlkTop
		jz	MakeMoveCL
		ror	bl, 2
		shl	cl, 2
		jnz	ChkForceTop

		mov	cl, 1
		mov	bx, GameBoard.O
ChkForceUL:	ForceBlkul
		jz	MakeMoveCL
		ror	bl, 2
		shl	cl, 2
		jnz	ChkForceUL

; Strategy #5: Find the first available empty cell and move there.

		mov	cl, 1
		mov	bx, GameBoard.O
		or	bx, GameBoard.X
FindEmpty:	shr	bx, 1
		jnc	MakeMoveCL
		shl	cl, 1
		jnz	FindEmpty

; If we hit this point, the game is over because the board is full.

		stc
		ret

; WinCL-	The CL register contains the bit that is the winning
;		move for the computer.

WinCL:		or	byte ptr GameBoard.O, cl
		stc
		ret

; MakeMoveCL-	The CL register contains the computer's move, but
;		the computer hasn't won yet.

MakeMoveCL:	or	byte ptr GameBoard.O, cl
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
