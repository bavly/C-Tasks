INCLUDE Irvine32.inc

.DATA
	CharsPerString = 10						;Constant
	stringsCount DWORD 20
	tempString BYTE charsPerString DUP(?) , 0

.CODE

main PROC

	MOV ECX, stringsCount
	L:
		MOV ESI, OFFSET tempString
		PUSH ECX
		MOV EBX, 65
		MOV EDX, 90
		MOV ECX, CharsPerString
		L2:	
			CALL BetterRandomRange
			MOV BYTE PTR [ESI], AL
			INC ESI
		LOOP L2
		MOV EDX, OFFSET tempString
		CALL WriteString
		CALL Crlf
		POP ECX
	LOOP L
	exit
main ENDP


;------------------------------------------------------------
; Generates a random number within a given range
; Receives: EDX Upper Bound
;		  , EBX Lower Bound
; Returns: EAX = random number
;------------------------------------------------------------
BetterRandomRange PROC USES EDX EBX
	
	;Total number of values = Upper Bound - Lower Bound + 1
	SUB EDX, EBX		
	INC EDX
	MOV EAX, EDX
	CALL RandomRange

	;Add Lower bound to the result to shift it back to the starting integer
	ADD EAX, EBX
	RET
BetterRandomRange ENDP

END main