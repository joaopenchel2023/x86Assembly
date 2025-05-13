[bits 16]
[org 0000h]
    
call OSMain


OSMain:
	call ConfigSegment
	call ConfigStack
	call VGA.SetVideoMode
	call DrawBackground
	call EffectInit
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

PrintString:
	mov ah, 09h
	mov bh, [Pagination]
	;mov bl, 1111_0001b
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
	mov ah, 00h
	int 16h
	mov ax, 0040h
	mov ds, ax
	mov ax, 1234h
	mov [0072h], ax
	jmp 0ffffh:0000h


; ===== DIRECTIVES INCLUSIONS =====

%INCLUDE "monitor.lib"

; ===== STARTING THE SYSTEM =====

Welcome db "Welcome to KiddieOS!",0


