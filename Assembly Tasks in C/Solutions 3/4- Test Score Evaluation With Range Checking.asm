INCLUDE Irvine32.inc

.DATA
	message BYTE "Enter Number Of Students: ",0
	gradeMessage BYTE "Enter Grade: ",0
	letterGradeMessage BYTE "Letter Grade: ",0
	invalidLessThan0 BYTE "Error grade must be greater than 0",0
	invalidMoreThan100 BYTE "Error grade must be less than 100",0
.CODE

main PROC	

MOV EDX, OFFSET message
CALL PromptForInteger
MOV ECX, EAX

Start:
	MOV EDX, OFFSET gradeMessage
	CALL PromptForInteger
	CALL CheckRange		
	CMP EBX, 0
	JE Skip
	CALL GetLetterGrade
	MOV EDX, OFFSET letterGradeMessage
	CALL WriteString
	CALL WriteChar
	CALL CRLF
	Skip:
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
; Checks the range to be [0-100]
; Receives: EAX has value
; Returns: EBX = 1 If Invalid 
;-----------------------------------------------------
CheckRange PROC USES EDX
	CMP EAX, 0
	JL lessThanZero
	CMP EAX, 100
	JG MoreThanHundred
	MOV EBX, 1
	JMP Next
	lessThanZero:
		MOV EDX, OFFSET invalidLessThan0
		CALL WriteString
		CALL CRLF
		MOV EBX, 0
		JMP Next
	MoreThanHundred:
		MOV EDX, OFFSET invalidMoreThan100
		CALL WriteString
		CALL CRLF
		MOV EBX, 0
	Next:
RET
CheckRange ENDP


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
