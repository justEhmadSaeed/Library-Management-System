INCLUDE IRVINE32.inc
.data
msg1 byte "### WELCOME TO LIBRARY MANAGEMENT SYSTEM ###", 0dh, 0ah, 0ah,
		"Choose One of the Following Options:", 0dh, 0ah,
		"1: Register a Member", 0dh, 0ah,
		"2: Unregister a Member", 0dh, 0ah,
		"3: View Members", 0dh, 0ah,
		"4: Exit Program", 0dh, 0ah, 0
REGISTER DWORD 1
UNREGISTER DWORD 2
VIEW DWORD 3
EXITP DWORD 4	
.code
MSG_DISPLAY proto, var: ptr dword
main proc
	INVOKE MSG_DISPLAY,addr MSG1
	CALL READINT
	CMP EAX, REGISTER
	JE REG
	CMP EAX, UNREGISTER
	JE UNREG
	CMP EAX, VIEW
	JE VIEW_M
	EXIT_MENU:
	REG:
	UNREG:
	VIEW_M:
	invoke ExitProcess,0
main endp
MSG_DISPLAY PROC USES EDX, VAR: ptr dword
	MOV EDX, VAR
	CALL WRITESTRING
	RET
	MSG_DISPLAY ENDP
end main