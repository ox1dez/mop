.686P
.MODEL FLAT, C


.DATA

.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 8
	mov esi, [ebp + 8]
	mov ecx, [ebp + 12]
	mov edi, [ebp + 16]
	xor eax, eax
i_loop:
	test ecx, ecx
	jz i_loop_end
	movsx eax, word ptr [esi]			; a[i]
	mov dword ptr [ebp - 4], 0			; count
	mov ebx, [ebp + 8]					; a
	mov edx, [ebp + 12]					; n
j_loop:
	test edx, edx
	jz	j_loop_end
	cmp word ptr [ebx], ax
	jne skip
	inc dword ptr [ebp - 4]
skip:
	add ebx, 2
	dec edx
	jmp j_loop
j_loop_end:
	mov eax, dword ptr [ebp - 4]
	mov [edi], eax
	xor eax, eax
	add esi, 2
	add edi, 2
	dec ecx
	jmp i_loop
i_loop_end:
	mov ecx, [ebp + 12]
	mov edi, [ebp + 16]
	xor eax, eax
	mov word ptr [ebp - 8], -32768
m_loop:
	test ecx, ecx
	jz finish
	mov ax, [edi]
	cmp ax, word ptr [ebp - 8]
	jle m_skip
	mov word ptr [ebp - 8], ax
m_skip:
	add edi, 2
	dec ecx
	jmp m_loop
finish:
	mov ax, word ptr [ebp - 8]
	mov esp, ebp
	pop ebp
	ret

main_f endp
END