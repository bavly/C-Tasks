INCLUDE Irvine32.inc

.DATA
	message BYTE "Enter Number Of Students: ",0
	gradeMessage BYTE "Enter Grade: ",0
	letterGradeMessage BYTE "Letter Grade: ",0

.CODE

main PROC	

MOV EDX, OFFSET message
CALL PromptForInteger
MOV ECX, EAX

Start:
	MOV EDX, OFFSET gradeMessage
	CALL PromptForInteger
	CALL GetLetterGrade
	MOV EDX, OFFSET letterGradeMessage
	CALL WriteString
	CALL WriteChar
	CALL CRLF
LOOP Start

	exit
main ENDP

;-----------------------------------------------------
; Asks the user for an Integer
; Receives: EDX points to the message 
; Returns: EAX user's number
;-----------------------------------------------------
PromptForInteger PROC 
	CALL WriteString		; display string
	CALL ReadInt			; read integer into EAX
RET
PromptForInteger ENDP

;-----------------------------------------------------
; Gets the letter grade that corresponds to a given integer grade
; Receives: EAX integer grade
; Returns: AL has letter grade
;-----------------------------------------------------
GetLetterGrade PROC 
	CMP EAX, 90
	JAE GradeA
	CMP EAX, 80
	JAE GradeB
	CMP EAX, 70
	JAE GradeC
	CMP EAX, 60
	JAE GradeD
	JMP GradeF

	GradeA:
		MOV AL, 'A'
		JMP Next
	GradeB:
		MOV AL, 'B'
		JMP Next
	GradeC:
		MOV AL, 'C'
		JMP Next
	GradeD:
		MOV AL, 'D'
		JMP Next
	GradeF:
		MOV AL, 'F'
	Next:
RET
GetLetterGrade ENDP

END main
