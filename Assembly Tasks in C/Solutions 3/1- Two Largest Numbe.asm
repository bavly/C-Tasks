INCLUDE Irvine32.inc

.DATA
	array DWORD 10 DUP (?)	
	message1 BYTE "Enter an integer : ",0
	message2 BYTE "Max 1 : ",0
	message3 BYTE "Max 2 : ",0

.CODE

main PROC	
	
	MOV ESI, OFFSET array
	MOV ECX, LENGTH array

	CALL AskUserForNumbers
	CALL CalculateTwoMax

	MOV EDX, OFFSET message2
	CALL WriteString
	CALL WriteInt
	CALL CRLF 

	MOV EDX, OFFSET message3
	CALL WriteString
	MOV EAX, EBX
	CALL WriteInt
	CALL CRLF 

	exit
main ENDP

;-----------------------------------------------------
; Prompts the user for an arbitrary number of integers
; and inserts the integers into an array.
; Receives: ESI points to the array, ECX = array size
; Returns: nothing
;-----------------------------------------------------
AskUserForNumbers PROC USES ECX EDX ESI

MOV EDX, OFFSET message1		
L1: 
	CALL WriteString		; display string
	CALL ReadInt			; read integer into EAX
	CALL Crlf				; go to next output line
	MOV [ESI],EAX			; store in array
	ADD ESI, TYPE DWORD		; next integer
LOOP L1
RET
AskUserForNumbers ENDP


;-----------------------------------------------------
; Calculate the 2 max numbers in an array
; Receives: ESI points to the array, ECX = array size
; Returns: EAX max 1 and EBX max 2 
;-----------------------------------------------------
CalculateTwoMax PROC USES ECX ESI
MOV EAX, 0FFFFFFFFh			; smallest number
MOV EBX, 0FFFFFFFFh

L1: 
	CMP DWORD PTR [ESI], EAX
	JG GreaterThanMax1
	CMP DWORD PTR [ESI], EBX
	JG GreaterThanMax2
	JMP Skip
	GreaterThanMax1:
		MOV EBX, EAX		; Max2 = Old Max1
		MOV EAX, DWORD PTR [ESI]
		JMP Skip
	GreaterThanMax2:
		MOV EBX, DWORD PTR [ESI]
	Skip:
		ADD ESI, TYPE DWORD		; next integer
LOOP L1

RET
CalculateTwoMax ENDP

END main