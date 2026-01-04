.686P
.MODEL FLAT, C

.DATA

.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 4						; גûהוכÿול ןאלÿעü ןמה count1
	mov esi, [ebp + 8]				; ebp = arr
	mov ecx, [ebp + 12]				; ecx = n

	mov ax, -32768					; m1
	mov bx, -32768					; m2
	mov dword ptr [ebp-4], 0		; cnt1 = 0
	xor edi, edi					; cnt2 = 0

i_loop:
	cmp ecx, 0
	je loop_done
	mov dx, [esi]					; dx = i
	cmp dx, ax
	jg new_m1						; if ( i > m1)
	cmp dx, ax
	je inc_m1						; if ( i == m1)
	cmp dx, bx					
	jg new_m2						; if ( i > m2)
	cmp dx, bx
	je inc_m2						; if ( i == m2)
	jmp skip						; else
new_m1:
	mov bx, ax
	mov edi, dword ptr [ebp-4]
	mov ax, dx
	mov dword ptr [ebp-4], 1
	jmp skip
new_m2:
	mov bx, dx
	mov edi, 1
	jmp skip
inc_m1:
	inc dword ptr [ebp-4]
    jmp skip
inc_m2:
	inc edi
skip:
	add esi, 2
	dec ecx
	jmp i_loop

loop_done:
	cmp edi, 0
	jne finded
	mov bx, 0F0F0h
	xor edi, edi
finded:
	add bx, di
	mov esi, [ebp + 8]				; esi = arr
	mov ecx, [ebp + 12]				; ecx = n
xor_loop:
	cmp ecx, 0
	je finish
	mov ax, [esi]
	xor ax, bx
	mov [esi], ax
	add esi, 2
	dec ecx
	jmp xor_loop

finish:
    mov esp, ebp
    pop ebp
    ret
main_f endp
END