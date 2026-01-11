.686P
.MODEL FLAT, C

.DATA

.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 20
	mov esi, [ebp + 8]					; a
	mov ecx, [ebp + 12]					; N
	mov word ptr [ebp - 4], 0			; res_start
	mov word ptr [ebp - 8], 1			; res_len
	mov word ptr [ebp - 12], 0			; cur_start
	mov word ptr [ebp - 16], 1			; cur_len
	mov ax, [esi]						; a[0]
	add esi, 2
	dec ecx
	test ax, 1
	jz even_first						; четное ?
	mov word ptr [ebp - 20], 1			; нечетное - 1
	jmp i_loop
even_first:
	mov word ptr [ebp - 20], 0			; четное - 0

i_loop:
	test ecx, ecx
	jz check_last
	mov ax, [esi]						; a[i]
	test ax, 1
	jz i_even
i_odd:									; если нечетное
	cmp word ptr [ebp - 20], 0
	je posl_prod
	jmp posl_end
i_even:
	cmp word ptr [ebp - 20], 1
	je posl_prod
	jmp posl_end
posl_prod:
	inc word ptr [ebp - 16]				; cur_len++
	jmp skip
posl_end:
	mov dx, word ptr [ebp - 16]
	cmp dx, word ptr [ebp - 8]
	jle posl_end_skip
	mov word ptr [ebp - 8], dx
	mov dx, word ptr [ebp - 12]
	mov word ptr [ebp - 4], dx
posl_end_skip:
	mov dx, word ptr [ebp - 16]
	add word ptr [ebp - 12], dx
	mov word ptr [ebp - 16], 1
skip:
	mov bx, ax
	and bx, 1
	mov word ptr [ebp - 20], bx
	add esi, 2
	dec ecx
	jmp i_loop
check_last:
	mov dx, word ptr [ebp - 16]
	cmp dx, word ptr [ebp - 8]
	jle finish
	mov word ptr [ebp - 8], dx
	mov dx, word ptr [ebp - 12]
	mov word ptr [ebp - 4], dx
finish:
	movsx eax, word ptr [ebp - 4]				; res start
	mov ebx, [ebp + 16]
	mov [ebx], eax
	movsx eax, word ptr [ebp - 8]				; res start
	mov ebx, [ebp + 20]
	mov [ebx], eax
	add esp, 20
	pop ebp
	ret
main_f endp
END