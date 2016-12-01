INCLUDE Irvine32.inc

.DATA
	menu BYTE "Choose Your Option", 0AH, 0DH, 
				  "1. X AND Y", 0AH, 0DH,
				  "2. X OR Y", 0AH, 0DH,
				  "3. NOT Y", 0AH, 0DH,
				  "4. X XOR Y", 0AH, 0DH,
				  "5. Exit program", 0AH, 0DH,0

	andMessage BYTE "AND = ",0
	orMessage BYTE "OR = ",0
	notMessage BYTE "NOT = ",0
	xorMessage BYTE "XOR = ",0

	message BYTE "Enter hex value : ", 0

.CODE

main PROC	

Start:
	MOV EDX, OFFSET menu
	CALL DisplayMenu

	CMP EAX, 1
	JE L1
	CMP EAX, 2
	JE L2
	CMP EAX, 3
	JE L3
	CMP EAX, 4
	JE L4
	CMP EAX, 5
	JE L5
	JMP Start

L1:
	MOV EDX, OFFSET andMessage
	CALL AND_OP
	JMP Next

L2:
	MOV EDX, OFFSET orMessage
	CALL OR_OP
	JMP Next

L3:
	MOV EDX, OFFSET notMessage
	CALL NOT_OP
	JMP Next

L4:
	MOV EDX, OFFSET xorMessage
	CALL XOR_OP
	JMP Next

L5:
	JMP EndProg

NEXT:
	CALL WriteString	;The operation 
	CALL WriteBin
	CALL CRLF
	JMP Start

EndProg:
	exit
main ENDP


;-----------------------------------------------------
; Presents the menu for the user and waits for input
; Receives: EDX points to the string that has the menu
; Returns: EAX user's choice
;-----------------------------------------------------
DisplayMenu PROC USES EDX
	CALL WriteString		; display string
	CALL ReadInt			; read integer into EAX
RET
DisplayMenu ENDP

;-----------------------------------------------------
; Asks the user for number
; Receives: Nothing
; Returns: EAX user's number
;-----------------------------------------------------
PromptForHexValue PROC USES EDX
	MOV EDX, OFFSET message
	CALL WriteString		; display string
	CALL ReadHex			; read integer into EAX
RET
PromptForHexValue ENDP

;-----------------------------------------------------
; AND 2 HEX values
; Receives: Nothing
; Returns: EAX Result of AND operation
;-----------------------------------------------------
AND_OP PROC USES EBX
	CALL PromptForHexValue
	MOV EBX, EAX		; First Value
	CALL PromptForHexValue
	AND EAX, EBX
RET
AND_OP ENDP

;-----------------------------------------------------
; OR 2 HEX values
; Receives: Nothing
; Returns: EAX Result of OR operation
;-----------------------------------------------------
OR_OP PROC USES EBX
	CALL PromptForHexValue
	MOV EBX, EAX		; First Value
	CALL PromptForHexValue
	OR EAX, EBX
RET
OR_OP ENDP


;-----------------------------------------------------
; NOT HEX values
; Receives: Nothing
; Returns: EAX Result of Not operation
;-----------------------------------------------------
NOT_OP PROC 
	CALL PromptForHexValue
	NOT EAX
RET
NOT_OP ENDP

;-----------------------------------------------------
; XOR 2 HEX values
; Receives: Nothing
; Returns: EAX Result of XOR operation
;-----------------------------------------------------
XOR_OP PROC USES EBX
	CALL PromptForHexValue
	MOV EBX, EAX		; First Value
	CALL PromptForHexValue
	XOR EAX, EBX
RET
XOR_OP ENDP

END main