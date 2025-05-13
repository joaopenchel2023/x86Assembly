[org 7c00h]
[bits 16]

call LoadSystem
call 0800h:0000h

LoadSystem:
	mov ah, 02h
	mov al, 01h
	mov ch, 00h
	mov cl, 02h
	mov dh, 00h
	mov dl, 80h
	mov bx, 0800h
	mov es, bx
	mov bx, 0000h
	int 13h
ret

times 510 - ($-$$) db 0
dw 0AA55h
