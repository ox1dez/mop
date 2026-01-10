.686P
.MODEL FLAT, C

.DATA

.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 4
	mov esi, [ebp + 8]					; s
	mov edi, [ebp + 12]					; res
	xor eax, eax
	xor edx, edx
i_loop:
	cmp byte ptr [esi], 0
	je i_loop_end
	mov al, [esi]
	mov dword ptr [ebp - 4], 0			; count = 0
	mov ebx, [ebp + 8]					; s
j_loop:
	cmp byte ptr [ebx], 0
	je j_loop_end
	mov dl, [ebx]
	cmp al, dl
	jne j_skip
	inc dword ptr [ebp - 4]
j_skip:
	add ebx, 1
	jmp j_loop
j_loop_end:
	cmp dword ptr [ebp - 4], 1
	jne i_skip
	mov byte ptr [edi], al
	add edi, 1
i_skip:
	add esi, 1
	jmp i_loop
i_loop_end:
	mov byte ptr [edi], 0
	add esp, 4
	pop ebp
	ret
main_f endp
END