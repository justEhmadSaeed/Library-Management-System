
; ***************************************
; ****** LIBRARY MANAGEMENT SYSTEM ******
; ***************************************

; ***************************************
; ************ SUBMITTED BY *************
; ***** EHMAD SAEED 	2018-CS-01 ******
; ***** ABDULLAH SALEEM	2018-CS-39 ******
; ***************************************
INCLUDE IRVINE32.inc
.DATA
msg1	 BYTE 0AH
		 BYTE	"	--------------------------------------------", 0dh, 0ah
		 BYTE	"	--  WELCOME TO LIBRARY MANAGEMENT SYSTEM  --", 0dh, 0ah
		 BYTE	"	--------------------------------------------", 0dh, 0ah, 0ah
		 BYTE	"	1-> Register a Member", 0dh, 0ah
		 BYTE	"	2-> View Members", 0dh, 0ah
		 BYTE	"	3-> View Members From File", 0dh, 0ah
		 BYTE	"	4-> Add Book", 0dh, 0ah
		 BYTE	"	5-> View Books", 0dh, 0ah
		 BYTE	"	6-> View Books From Files", 0dh, 0ah
		 BYTE	"	7-> Exit Program", 0dh, 0ah
		 BYTE	"	Choose Your Option : ", 0
REG_MSG	 BYTE "	Enter Member's Name to register: ",0
VIEW_MEMBERS_MSG BYTE 0Ah,"	Viewing Registered Members: ",0AH, 0DH, 0
ADD_MSG			 BYTE "	Enter Book Name & Author Name to Add: ", 0dh, 0ah,
			 "	Separated By Comma:",0
VIEW_BOOKS_MSG BYTE 0Ah, "	Viewing Books in Library: ",  0dh, 0ah, 0
EXIT_MSG	   BYTE 0AH,
				    "	----------------- ",0dh, 0ah,
				    "	Exiting Program...",0dh, 0ah,
					"	See you again  :')",0dh, 0ah,
					"	------------------", 0
bool		   DWORD ?
MEMBERS_FILE   BYTE "MEMBERS.txt",0
BOOKS_FILE     BYTE "BOOKS.txt",0
filehandle     DWORD ?
BUFFER_SIZE = 5000
buffer_mem   BYTE buffer_size DUP (?)
buffer_book  BYTE buffer_size DUP (?)
bytesRead dword 1 dup(0)
REGISTER	 DWORD 1
VIEW_MEMBERS DWORD 2
VIEW_MF		 DWORD 3
ADD_BOOK	 DWORD 4
VIEW_BOOKS	 DWORD 5
VIEW_BF		 DWORD 6
EXITP		 DWORD 7	
MEMBER_SIZE = 20
MEMBER1 DB MEMBER_SIZE DUP (?)
MEMBER2 DB MEMBER_SIZE DUP (?)
MEMBER3 DB MEMBER_SIZE DUP (?)
MEMBER4 DB MEMBER_SIZE DUP (?)
MEMBER5 DB MEMBER_SIZE DUP (?)
MEMBER6 DB MEMBER_SIZE DUP (?)
NUM_MEMBERS DWORD 0
MEMBERS DD MEMBER1, MEMBER2, MEMBER3, MEMBER4, MEMBER5, MEMBER6, 0AH, 0DH, 0

BOOK_SIZE = 30
BOOK1 DB BOOK_SIZE DUP (?)
BOOK2 DB BOOK_SIZE DUP (?)
BOOK3 DB BOOK_SIZE DUP (?)
BOOK4 DB BOOK_SIZE DUP (?)
BOOK5 DB BOOK_SIZE DUP (?)
BOOK6 DB BOOK_SIZE DUP (?)
NUM_BOOKS DWORD 0
BOOKS DD BOOK1, BOOK2, BOOK3, BOOK4, BOOK5, BOOK6, 0AH, 0DH, 0
.CODE
MSG_DISPLAY proto, var: PTR DWORD
STRING_INPUT proto, var1: PTR DWORD
main PROC
	START:
	INVOKE MSG_DISPLAY,addr MSG1
	CALL READINT

	CMP EAX, REGISTER
	JE REG_M
	CMP EAX, VIEW_MEMBERS
	JE VIEW_M
	CMP EAX, VIEW_MF
	JE VIEW_MFILE
	CMP EAX, ADD_BOOK
	JE ADD_B
	CMP EAX, VIEW_BOOKS
	JE VIEW_B
	CMP EAX, VIEW_BF
	JE VIEW_BFILE
		JMP EXIT_MENU

;----------------------------------------
;------------REGISTER MEMBERS------------
;----------------------------------------
	REG_M:
		INVOKE MSG_DISPLAY, ADDR REG_MSG
		;INVOKE STRING_INPUT, ADDR INPUT_STRING

	MOV ESI, OFFSET MEMBERS
	MOV EAX, MEMBER_SIZE
	MUL NUM_MEMBERS
	ADD ESI, EAX
	MOV EDX, ESI
	MOV ECX, MEMBER_SIZE
	CALL READSTRING
	INC NUM_MEMBERS

	;INVOKE CreateFile,
	;ADDR MEMBERS_FILE,
	;GENERIC_WRITE,
	;DO_NOT_SHARE, 
	;NULL, 
	;OPEN_ALWAYS, 
	;FILE_ATTRIBUTE_NORMAL, 
	;0
;
;cmp eax, INVALID_HANDLE_VALUE
	;je exit_1
	;mov filehandle, eax
;INVOKE SetFilePointer,
	 ;filehandle,
	;0, ; distance low
	;0, ; distance high
	;FILE_END
	;mov eax,filehandle
;
	;mov edx, offset BUFFER_MEM
	;mov ecx, 7
	;call READSTRING
	;mov eax, filehandle
	;call WriteToFile
;
	;INVOKE SetFilePointer,
	 ;filehandle,
	;0, ; distance low
	;0, ; distance high
	;FILE_END
;exit_1:
	;invoke CloseHandle, filehandle

		JMP START

;--------------------------------------
;--------------VIEW MEMBERS------------
;--------------------------------------
	VIEW_M:
		INVOKE MSG_DISPLAY, ADDR VIEW_MEMBERS_MSG
	MOV ECX, NUM_MEMBERS
	cmp ECX, 0
	JE START
	MOV EBX, 0
OUTPUT:
	MOV ESI, OFFSET MEMBERS
	MOV EAX, MEMBER_SIZE
	MUL EBX
	ADD ESI, Eax
	MOV EDX, ESI
	CALL WRITESTRING
	INC EBX
	CALL CRLF
LOOP OUTPUT
		JMP START

; VIEW MEMBERS FROM FILE
VIEW_MFILE:
	INVOKE CreateFile,
	ADDR MEMBERS_FILE, ; ptr to filename
	GENERIC_READ, ; mode = Can read
	DO_NOT_SHARE, ; share mode
	NULL, ; ptr to security attributes
	OPEN_ALWAYS, ; open an existing file
	FILE_ATTRIBUTE_NORMAL, ; normal file attribute
	0 ; not used
	mov filehandle, eax ; Copy handle to variable
	invoke ReadFile,
	filehandle, ; file handle
	addr BUFFER_MEM, ; where to read
	BUFFER_SIZE, ; num bytes to read
	addr bytesRead, ; bytes actually read
	0
	invoke CloseHandle,
	filehandle
	mov edx, offset BUFFER_MEM ; Write String
	call WriteString
	JMP START
;----------------------------------
;--------------ADD BOOKS-----------
;----------------------------------	
	ADD_B:

	INVOKE MSG_DISPLAY, ADDR ADD_MSG
	MOV ESI, OFFSET BOOKS
	MOV EAX, BOOK_SIZE
	MUL NUM_BOOKS
	ADD ESI, EAX
	MOV EDX, ESI
	MOV ECX, BOOK_SIZE
	CALL READSTRING
	INC NUM_BOOKS
		
	JMP START
;------------------------------------
;-------------VIEW BOOKS-------------
;------------------------------------
	VIEW_B:
	
	INVOKE MSG_DISPLAY, ADDR VIEW_BOOKS_MSG
	MOV ECX, NUM_BOOKS
	cmp ECX, 0
	JE START
	MOV EBX, 0
OUTPUTB:
	MOV ESI, OFFSET BOOKS
	MOV EAX, BOOK_SIZE
	MUL EBX
	ADD ESI, Eax
	MOV EDX, ESI
	CALL WRITESTRING
	INC EBX
	CALL CRLF	
LOOP OUTPUTB
		
JMP START
; VIEW BOOKS FROM FILE
VIEW_BFILE:
	INVOKE CreateFile,
	ADDR BOOKS_FILE, ; ptr to filename
	GENERIC_READ, ; mode = Can read
	DO_NOT_SHARE, ; share mode
	NULL, ; ptr to security attributes
	OPEN_ALWAYS, ; open an existing file
	FILE_ATTRIBUTE_NORMAL, ; normal file attribute
	0 ; not used
	mov filehandle, eax ; Copy handle to variable
	invoke ReadFile,
	filehandle, ; file handle
	addr BUFFER_BOOK, ; where to read
	BUFFER_SIZE, ; num bytes to read
	addr bytesRead, ; bytes actually read
	0
	invoke CloseHandle,
	filehandle
	mov edx, offset BUFFER_BOOK ; Write String
	call WriteString
	JMP START
;-------------------------------------------
;----------------EXIT MENU------------------
;-------------------------------------------
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
	MOV ECX, 5000
	CALL READSTRING
	RET
	STRING_INPUT ENDP

end main
