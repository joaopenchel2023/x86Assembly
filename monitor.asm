%IFNDEF __MONITOR_LIB__
%DEFINE __MONITOR_LIB__
    
; ===== Main Strings =====

NameSystem db "KiddieOS",0

; ===== MONITOR AND WINDOW CONFIGURATION =====

count		dw 0000h

BackWidth	dw 0000h
BackHeight	dw 0000h
BackColor	db 46
Pagination	db 0
CursorX		db 15
CursorY		db 12

State		db 0

Key		db 0

; ===== Routine Lybraries =====




; ===== Define the Video Mode and configure position =====
	
VGA.SetVideoMode:
	mov ah, 00
	mov al, 13h
	int 10h
	mov ax, 320
	mov WORD[BackWidth], ax
	mov ax, 200
	mov WORD[BackHeight], ax
	call DrawPixelConfig
ret

DrawPixelConfig:
	mov ah, 0ch
	mov al, [BackColor]
	mov cx, 0
	mov dx, 0
ret

DrawBackground:
	int 10h
	inc cx
	cmp cx, WORD[BackWidth]
	jne DrawBackground
	mov cx, 0
	inc dx
	cmp dx, WORD[BackHeight]
	jne DrawBackground
	mov dx, 0
ret

EffectInit:
	mov bl, 44
	start:
		mov dh, [CursorY]
		mov dl, [CursorX]
		call MoveCursor
		mov si, NameSystem
		call PrintString
		pusha
		mov bl, [State]
		cmp bl, 0
		je Increment
		jmp Decrement
	Increment:
		popa
		inc bl
		call Waiting
		cmp bl, 50
		jne start
		pusha
		mov bl, 1
		mov byte[State], bl
		popa
		jmp start
	Decrement:
		popa
		dec bl
		call Waiting
		cmp bl, 44
		jne start
		pusha
		mov bl, 0
		mov byte[State], bl
		mov bx, [Count]

ret

Wainting:
	

	

%ENDIF
