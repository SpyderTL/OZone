; TIC-TAC-TOE
; (TTT3.ASM)
;
; An implementation of the Tic-Tac-Toe game in assembly language.
;
; Implementation #3: using regular expressions to indicate the moves to make.
;
; Uses the UCR Standard Library v2.0 for 80x86 assembly language programmers.
;
; Randall Hyde
;
; 8/16/96

		.386
		option	segment:use16

		.xlist
                include         ucrlib.a
                includelib      ucrlib.lib
		.list



dseg		segment	para public 'data'

MoveCntr	word	0

GameBoard	byte	"         ",0


OMoves          byte    0," OO......"
                byte    6,"O..O.. .."
                byte    8,"......OO "
                byte    2,".. ..O..O"

                byte    0," ..O..O.."
                byte    6,"...... OO"
                byte    8,"..O..O.. "
                byte    2,"OO ......"

                byte    0," ...O...O"
                byte    6,"..O.O. .."
                byte    8,"O...O... "
                byte    2,".. .O.O.."

                byte    1,"O O......"
                byte    3,"O.. ..O.."
                byte    7,"......O O"
                byte    5,"..O.. ..O"

                byte    1,". ..O..O."
                byte    3,"... OO..."
                byte    7,".O..O.. ."
                byte    5,"...OO ..."
OCnt		=	($-OMoves)/10


XMoves		byte	1,"  X . X  "


                byte    0," XX......"
                byte    6,"X..X.. .."
                byte    8,"......XX "
                byte    2,".. ..X..X"

                byte    0," ..X..X.."
                byte    6,"...... XX"
                byte    8,"..X..X.. "
                byte    2,"XX ......"

                byte    0," ...X...X"
                byte    6,"..X.X. .."
                byte    8,"X...X... "
                byte    2,".. .X.X.."

                byte    1,"X X......"
                byte    3,"X.. ..X.."
                byte    7,"......X X"
                byte    5,"..X.. ..X"

                byte    1,". ..X..X."
                byte    3,"... XX..."
                byte    7,".X..X.. ."
                byte    5,"...XX ..."


                byte    0," X X.. .."
		byte	6," ..X.. X "
		byte	8,".. ..X X "
		byte	2," X ..X.. "

                byte    0,"  XX.. .."
		byte	6,"X.. .. X "
		byte	8,".. .XX   "
		byte	2,"X  ..X.. "

                byte    0," X  ..X.."
		byte	6," ..X..  X"
		byte	8,"..X..  X "
		byte	2,"X  ..X.. "

XCnt		=	($-XMoves)/10

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
; PSNum-	Outputs a single digit in the range 0..8 to denote
;		the key the user should press to select a give cell.
;		PSNum only outputs the digit if this is a possible
;		move for the play (i.e., the cell is current unoccupied).
;		It outputs a blank to the cell if a move is not possible.
;
; DispTTT-	Calls the above routine to display the tic-tac-toe
;		board.




; PSNum-	Outputs a digit to a TTT cell if that position is
;		unoccupied, outputs a blank to a cell if that position
;		is occupied and the user cannot move there.  SI contains
;		the cell # (0-8).

PSNum		textequ	<call _PSNum>
_PSNum		proc	near

		putc	" "
		mov	al, GameBoard[si]
		cmp	al, " "
		mov	al, " "
		jne	PutCell
		mov	ax, si
		or	al, '0'
PutCell:	putc
		putc	" "
		inc	si		;On to next cell.
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
		putcr
		jmp	PrtTTT

; Each execution of the following loop prints one row on the game board
; and one row on the possible moves board.

PrtLoop:	print	"---+---+---  ---+---+---",nl
PrtTTT:		PSNum		;Display possible moves.
		putc	"|"
		PSNum
		putc	"|"
		PSNum

		print	"   "
		         
		mov	al, GameBoard[si-3]
		putc
		print	" | "	; moves thus far.

		mov	al, GameBoard[si-2]
		putc
		print	" | "

		mov	al, GameBoard[si-1]
		putc
		putcr
		cmp	si, 9
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
RptInput:	rawgetc				;Read a single character
		putc				; (unbuffered) and check to see
		tolower				; if the user wants to quit.
		cmp	al, 'q'
		je	QuitGame
		sub	al, '0'			;Check for a digit.  Anything else
		cmp	al, 9			; is an error.
		jae	BadInput

		mov	bl, al			;Check to see if this
		mov	bh, 0			; location on the board
		cmp	GameBoard[bx], ' '	; is already occupied.
		jne	BadInput

		mov	GameBoard[bx], 'X'	;Make the player's move.

		pop	bx
		pop	ax
		ret

QuitGame:	ExitPgm
_GetMove	endp
		


TryOMov		textequ	<call _tryOMove>
_tryOMove	proc	near
		push	ax
		push	bx
		push	cx
		mov	bx, 0
		mov	cx, 9
CmpLoop:	mov	al, [si+1][bx]
		cmp	al, '.'
		je	Equal
		cmp	al, GameBoard[bx]
		jne	NotEqual
Equal:		inc	bx
		loop	CmpLoop
		stc
		pop	cx
		pop	bx
		pop	ax
		ret

NotEqual:	clc
		pop	cx
		pop	bx
		pop	ax
		ret
_tryOMove	endp



; CmptMov-	Compute the next move for the Computer "player"

CmptMov		textequ	<call _cmove>
_cmove		proc	near

		lea	si, OMoves
		mov	cx, OCnt
TryToWin:	TryOMov
		jc	Won
		add	si, 10
		loop	TryToWin

		lea	si, XMoves
		mov	cx, XCnt
TryToBlk:	TryOMov
		jc	Moved
		add	si, 10
		loop	TryToBlk

; If we fall down here, just pick the first empty cell.

		lea	si, GameBoard
FindBlank:	cmp	byte ptr [si], ' '
		je	FoundOne
		inc	si
		jmp	FindBlank

FoundOne:	mov	byte ptr [si], 'O'
		clc
		ret

Won:		mov	bl, [si]
		mov	bh, 0
		mov	GameBoard[bx], 'O'
		stc
		ret

Moved:		mov	bl, [si]
		mov	bh, 0
		mov	GameBoard[bx],'O'
		clc
		ret
_cmove		endp		
		

		
Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax



; Do the first move manually.
; If the user chooses the middle cell, pick the upper left hand
; cell.  Otherwise pick the middle cell.

		DispTTT
		GetMove
		cmp	GameBoard+4, " "	;Middle Square?
		je	MoveMiddle
		mov	GameBoard, "O"	;Upper left corner.
		jmp	SecondMove

MoveMiddle:	mov	GameBoard+4, "O"


; Okay, after the first move we need to get smart...

SecondMove:	mov	MoveCntr, 4	;Five possible moves, just did one.
NextMove:	DispTTT
		GetMove
		dec	MoveCntr	;Max possible four moves
		jz	GameOver	;Board full if four moves occur.


		CmptMov
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
