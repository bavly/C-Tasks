INCLUDE Irvine32.inc

.DATA
	testString BYTE "This is a test string !", 0	
	foregroundColors DWORD WHITE, BLUE, GREEN, RED
	backgroundColors DWORD LIGHTBLUE, CYAN, YELLOW, GRAY

.CODE
main PROC	
	
	MOV ESI, 0;
	MOV ECX, 4
	L:
	MOV EBX, backgroundColors[ESI]
	SHL EBX, 4						; *16
	MOV EAX, foregroundColors[ESI]
	ADD EAX, EBX
	CALL SetTextColor
	MOV EDX, OFFSET testString
	CALL WriteString
	ADD ESI, 4 
	CALL Crlf
	LOOP L
	
	MOV EAX, WHITE+(BLACK * 16)
	CALL SetTextColor
	exit
main ENDP

END main