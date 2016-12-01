INCLUDE Irvine32.inc

.DATA
	firstPrompt BYTE "Enter Lower Bound: ", 0	
	secondPrompt BYTE "Enter Upper Bound: ", 0	

.CODE

main PROC
	MOV EDX, OFFSET firstPrompt
	CALL WriteString
	CALL ReadInt		
	PUSH EAX					;EAX has the lower bound

	MOV EDX, OFFSET secondPrompt
	CALL WriteString
	CALL ReadInt				;EAX has the upper bound
	MOV EDX, EAX				;EDX has the upper bound
	POP EBX						;EBX has the lower bound that was pushed before
	
	MOV ECX, 50
	L:
	CALL BetterRandomRange
	CALL WriteInt
	CALL Crlf
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