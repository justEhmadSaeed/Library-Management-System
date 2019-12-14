INCLUDE IRVINE32.inc
.data
msg1 byte 0AH, "### WELCOME TO LIBRARY MANAGEMENT SYSTEM ###", 0dh, 0ah, 0ah,
		"Choose One of the Following Options:", 0dh, 0ah,
		"1: Register a Member", 0dh, 0ah,
		"2: Unregister a Member", 0dh, 0ah,
		"3: View Members", 0dh, 0ah,
		"4: Exit Program", 0dh, 0ah, 0
REG_MSG BYTE "Enter Member's Name to register: ",0
UNREG_MSG BYTE "Enter Member's Name to unregister: ",0
VIEW_MSG BYTE "Viewing Registered Members: ",0
EXIT_MSG BYTE "Exiting Program...",0dh, 0ah,
				"See you again :')", 0
REGISTER DWORD 1
UNREGISTER DWORD 2
VIEW DWORD 3
EXITP DWORD 4	
.code
MSG_DISPLAY proto, var: ptr dword
main proc
	START:
	INVOKE MSG_DISPLAY,addr MSG1
	CALL READINT
	CMP EAX, REGISTER
	JE REG
	CMP EAX, UNREGISTER
	JE UNREG
	CMP EAX, VIEW
	JE VIEW_M
		JMP EXIT_MENU
	REG:
		INVOKE MSG_DISPLAY, ADDR REG_MSG
		JMP START
	UNREG:
		INVOKE MSG_DISPLAY, ADDR UNREG_MSG
		JMP START
		
	VIEW_M:
		INVOKE MSG_DISPLAY, ADDR VIEW_MSG

		JMP START
		
	EXIT_MENU:
		INVOKE MSG_DISPLAY, ADDR EXIT_MSG
	
	invoke ExitProcess,0
main endp
MSG_DISPLAY PROC USES EDX, VAR: ptr dword
	MOV EDX, VAR
	CALL WRITESTRING
	RET
	MSG_DISPLAY ENDP
end main