[bits 16]
[org 0000h]
    
call OSMain


OSMain:
	call ConfigSegment
	call ConfigStack
	call VGA.SetVideoMode
	call DrawBackground
	;call TEXT.SetVideoMode
	;call BackColor
	;call ShowString
	call End

; ===== KERNEL FUNCTIONS =====

ConfigSegment:
	mov ax, es
	mov ds, ax
ret

ConfigStack:
	mov ax, 7D00h
	mov ss, ax
	mov sp, 03FEh
ret


;TEXT.SetVideoMode:
;	mov ah, 00h
;	mov al, 03h
;	int 10h
;	mov BYTE[BackWidth], 80
;	mov BYTE[BackHeight], 20
;ret

;BackColor:
;	mov ah, 06h
;	mov al, 00h
;	mov bh, 0001_1111b
;	mov ch, 0
;	mov cl, 0
;	mov dh, 5
;	mov dl, 80h
;	int 10h
;ret

;ShowString:
;	mov dh, 3
;	mov dl, 2
;	call MoveCursor
;	mov si, Welcome
;	call PrintString
;ret

PrintString:
	mov ah, 09h
	mov bh, [Pagination]
	mov bl, 1111_0001b
	mov cx, 01h
	mov al, [si]
	print:
		int 10h
		inc si
		call MoveCursor
		mov ah, 09h
		mov al, [si]
		cmp al, 0
		jne print
ret

MoveCursor:
	mov ah, 02h
	mov bh, [Pagination]
	inc dl
	int 10h
ret

End:
	;jmp $
	mov ah, 00h
	int 16h
	;int 19h
	mov ax, 0040h
	mov ds, ax
	mov ax, 1234h
	mov [0072h], ax
	jmp 0ffffh:0000h


; ===== DIRECTIVES INCLUSIONS =====

%INCLUDE "monitor.lib"

; ===== STARTING THE SYSTEM =====

;BackWidth db 0
;BackHeight db 0
;Pagination db 0

Welcome db "Welcome to KiddieOS!",0


