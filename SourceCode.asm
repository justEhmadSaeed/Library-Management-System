INCLUDE IRVINE32.inc
.data
msg1 byte "### WELCOME TO LIBRARY MANAGEMENT SYSTEM ###", 0dh, 0ah, 0ah,
		"Choose One of the Following Options:", 0dh, 0ah,0
.code
MSG_DISPLAY proto, var: ptr dword
main proc
	INVOKE MSG_DISPLAY,addr MSG1

	invoke ExitProcess,0
main endp
MSG_DISPLAY PROC USES EDX, VAR: ptr dword
	MOV EDX, VAR
	CALL WRITESTRING
	RET
	MSG_DISPLAY ENDP
end main