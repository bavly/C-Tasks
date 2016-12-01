; This program prompts the user for three integers,
; stores them in an array, calculates the sum of the
; array, and displays the sum.

INCLUDE Irvine32.inc
ARRAY_SIZE = 20

.DATA
str1 BYTE "Enter a signed integer: ", 0
str2 BYTE "The sum of the integers is: ", 0
str3 BYTE "How many integers will be added? ", 0
array DWORD ARRAY_SIZE DUP(?)

.CODE

main PROC
	CALL ClrScr
	CALL PromptForArraySize
	MOV ECX, EAX
	MOV ESI, OFFSET array
	CALL PromptForIntegers

	CALL ArraySum
	CALL DisplaySum

exit
main ENDP

;-----------------------------------------------------
PromptForArraySize PROC USES EDX
;
; Prompts the user for the count of integers
; Returns: EAX count
;-----------------------------------------------------
MOV EDX, OFFSET str3
CALL WriteString
CALL ReadInt

RET
PromptForArraySize ENDP

;-----------------------------------------------------
PromptForIntegers PROC USES ECX EDX ESI
;
; Prompts the user for an arbitrary number of integers
; and inserts the integers into an array.
; Receives: ESI points to the array, ECX = array size
; Returns: nothing
;-----------------------------------------------------

MOV EDX, OFFSET str1		; "Enter a signed integer"
L1: 
	CALL WriteString		; display string
	CALL ReadInt			; read integer into EAX
	CALL Crlf				; go to next output line
	MOV [ESI],EAX			; store in array
	ADD ESI, TYPE DWORD		; next integer
LOOP L1
RET
PromptForIntegers ENDP

;-----------------------------------------------------
ArraySum PROC USES ESI ECX
;
; Calculates the sum of an array of 32-bit integers.
; Receives: ESI points to the array, ECX = number
; of array elements
; Returns: EAX = sum of the array elements
;-----------------------------------------------------

MOV EAX, 0					; set the sum to zero
L1: 
	ADD EAX, [ESI]			; add each integer to sum
	ADD ESI,TYPE DWORD		; point to next integer
LOOP L1						; repeat for array size
RET							; sum is in EAX
ArraySum ENDP

;-----------------------------------------------------
DisplaySum PROC USES EDX
;
; Displays the sum on the screen
; Receives: EAX = the sum
; Returns: nothing
;-----------------------------------------------------

MOV EDX, OFFSET str2		; "The sum of the..."
CALL WriteString
CALL WriteInt				; display EAX
CALL Crlf
RET
DisplaySum ENDP

END main
