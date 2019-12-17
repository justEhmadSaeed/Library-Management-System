INCLUDE IRVINE32.inc
.DATA
msg1	 BYTE 0AH
		 BYTE	"	--------------------------------------------", 0dh, 0ah
		 BYTE	"	--  WELCOME TO LIBRARY MANAGEMENT SYSTEM  --", 0dh, 0ah
		 BYTE	"	--------------------------------------------", 0dh, 0ah, 0ah
		 BYTE	"	1-> Register a Member", 0dh, 0ah
		 BYTE	"	2-> View Members", 0dh, 0ah
		 BYTE	"	3-> Add Book", 0dh, 0ah
		 BYTE	"	4-> View Books", 0dh, 0ah
		 BYTE	"	5-> Exit Program", 0dh, 0ah
		 BYTE	"	Choose Your Option : ", 0
REG_MSG	 BYTE "	Enter Member's Name to register: ",0
VIEW_MEMBERS_MSG BYTE "	Viewing Registered Members: ",0
ADD_MSG			 BYTE "	Enter Book Name & Author Name to Add: ", 0dh, 0ah,
			 "	Separated By Comma:",0
VIEW_BOOKS_MSG BYTE "	Viewing Books in Library: ",0
EXIT_MSG	   BYTE "	Exiting Program...",0dh, 0ah,
				"	See you again :')", 0
bool		   DWORD ?
MEMBERS_FILE   BYTE "MEMBERS.txt",0
BOOKS_FILE     BYTE "BOOKS.txt",0
filehandle     DWORD ?
BUFFER_SIZE = 5000
MAX_INPUT = 40
INPUT_STRING BYTE MAX_INPUT+1 DUP (?)
buffer_mem   BYTE buffer_size DUP (?)
buffer_book  BYTE buffer_size DUP (?)
REGISTER	 DWORD 1
UNREGISTER   DWORD 2
VIEW_MEMBERS DWORD 3
ADD_BOOK	 DWORD 4
REMOVE_BOOK  DWORD 5
VIEW_BOOKS	 DWORD 6
EXITP		 DWORD 7	
.CODE
MSG_DISPLAY proto, var: PTR DWORD
STRING_INPUT proto, var1: PTR DWORD
main PROC
	START:
	INVOKE MSG_DISPLAY,addr MSG1
	CALL READINT

	CMP EAX, REGISTER
	JE REG_M
	CMP EAX, UNREGISTER
	JE UNREG_M
	CMP EAX, VIEW_MEMBERS
	JE VIEW_M
	CMP EAX, ADD_BOOK
	JE ADD_B
	CMP EAX, REMOVE_BOOK
	JE REMOVE_B
	CMP EAX, VIEW_BOOKS
	JE VIEW_B
		JMP EXIT_MENU

;----------------------------------------
;------------REGISTER MEMBERS------------
;----------------------------------------
	REG_M:
		INVOKE MSG_DISPLAY, ADDR REG_MSG
		;INVOKE STRING_INPUT, ADDR INPUT_STRING

		INVOKE CreateFile,
	ADDR MEMBERS_FILE,
	GENERIC_WRITE,
	DO_NOT_SHARE, 
	NULL, 
	OPEN_ALWAYS, 
	FILE_ATTRIBUTE_NORMAL, 
	0

cmp eax, INVALID_HANDLE_VALUE
	je exit_1
	mov filehandle, eax
INVOKE SetFilePointer,
	 filehandle,
	0, ; distance low
	0, ; distance high
	FILE_END
	mov eax,filehandle

	mov edx, offset BUFFER_MEM
	mov ecx, 7
	call READSTRING
	mov eax, filehandle
	call WriteToFile

	INVOKE SetFilePointer,
	 filehandle,
	0, ; distance low
	0, ; distance high
	FILE_END
exit_1:
	invoke CloseHandle, filehandle

		JMP START

;--------------------------------------
;--------------VIEW MEMBERS------------
;--------------------------------------
	VIEW_M:
		INVOKE MSG_DISPLAY, ADDR VIEW_MEMBERS_MSG

		JMP START
;----------------------------------
;--------------ADD BOOKS-----------
;----------------------------------	
	ADD_B:
		INVOKE MSG_DISPLAY, ADDR ADD_MSG
		;INVOKE STRING_INPUT, ADDR INPUT_STRING
INVOKE CreateFile,
	ADDR BOOKS_FILE,
	GENERIC_WRITE,
	DO_NOT_SHARE, 
	NULL, 
	OPEN_ALWAYS, 
	FILE_ATTRIBUTE_NORMAL, 
	0

cmp eax, INVALID_HANDLE_VALUE
	je exit_2
	mov filehandle, eax
INVOKE SetFilePointer,
	 filehandle,
	0, ; distance low
	0, ; distance high
	FILE_END
	mov eax,filehandle

	mov edx, offset BUFFER_BOOK
	mov ecx, 15
	call READSTRING
	mov eax, filehandle
	call WriteToFile

	INVOKE SetFilePointer,
	 filehandle,
	0, ; distance low
	0, ; distance high
	FILE_END
exit_2:
	invoke CloseHandle, filehandle
		JMP START
;------------------------------------
;-------------VIEW BOOKS-------------
;------------------------------------
	VIEW_B:
		INVOKE MSG_DISPLAY, ADDR VIEW_BOOKS_MSG
		
		
		JMP START

	EXIT_MENU:
		INVOKE MSG_DISPLAY, ADDR EXIT_MSG
	
	invoke ExitProcess,0
main endp
;-------------------------------------------
;--------FUNCTION TO DISPLAY A STRING-------
;-------------------------------------------
MSG_DISPLAY PROC USES EDX, VAR: ptr dword
	MOV EDX, VAR
	CALL WRITESTRING
	RET
	MSG_DISPLAY ENDP

STRING_INPUT PROC USES EDX ECX, var: ptr dword
		
	MOV EDX, VAR
	MOV ECX, MAX_INPUT
	CALL READSTRING
	RET
	STRING_INPUT ENDP

end main