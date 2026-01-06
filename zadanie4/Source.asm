.686P
.MODEL FLAT, C

.DATA
	d13 dw 13
	d2   dd 2

.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 12
	mov esi, [ebp + 8]					; arr
	mov ecx, [ebp + 12]					; n
	mov edi, [ebp + 16]					; res
	mov dword ptr [ebp - 4], 0			; sum
	mov dword ptr [ebp - 12], 0			; k
	xor ebx, ebx						; count
i_loop:
	xor eax, eax
	test ecx, ecx
	jz i_loop_end
	mov ax, word ptr [esi]				; a[i]
	cwd
	idiv d13
	cmp dx, 0
	jne skip
	movsx eax, word ptr [esi]			; a[i]
	add dword ptr [ebp - 4], eax
	inc ebx
skip:
	add esi, 2
	dec ecx
	jmp i_loop
i_loop_end:
	xor edx, edx
	mov eax, dword ptr [ebp - 4]
	cdq
	idiv ebx
	mov dword ptr [ebp - 8], eax		; M
	xor edx, edx
	xor eax, eax
	mov esi, [ebp + 8]					; arr
	mov ecx, [ebp + 12]					; n
x_loop:
	test ecx, ecx
	jz x_loop_end
	movsx edx, word ptr [esi]
	cmp edx, [ebp - 8]
	jg greater
	jmp x_skip
greater:
	mov [edi], dx
	add edi, 2
	inc dword ptr [ebp - 12]
x_skip:
	add esi, 2
	dec ecx
	jmp x_loop
x_loop_end:
	mov eax, dword ptr [ebp - 12]
	mov esp, ebp
	pop ebp
	ret

main_f endp
END