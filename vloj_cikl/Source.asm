.686P
.MODEL FLAT, C

; задача определить сколько элементво строго меньше a[i] и записать в массив res
	
.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 8
	mov esi, [ebp + 8]					; a
	mov ecx, [ebp + 12]					; n
	mov edi, [ebp + 16]					; res
	mov dword ptr [ebp - 8], 0			; sum(count)
	add edi, 2							; первый останетс€ под среднее арифметическое
	xor eax, eax
i_loop:
	test ecx, ecx
	jz i_loop_end
	mov ax, [esi]						; a[i]
	mov word ptr [ebp - 4], 0			; count = 0
	mov ebx, [ebp + 8]					; a
	mov edx, [ebp + 12]					; n
j_loop:
	test edx, edx
	jz j_loop_end
	cmp word ptr [ebx], ax
	jge j_skip
	inc word ptr [ebp - 4]
j_skip:
	add ebx, 2
	dec edx
	jmp j_loop
j_loop_end:
	movsx eax, word ptr [ebp - 4]
	mov [edi], ax						; кладем в edi количество
	add dword ptr [ebp - 8], eax		; прибавл€ем к сумме 
	add esi, 2
	add edi, 2
	dec ecx
	jmp i_loop
i_loop_end:
	mov edi, [ebp + 16]					; res[0]
	mov eax, dword ptr [ebp - 8]		; sum(count)
	cdq
	idiv dword ptr [ebp + 12]			; делим на размер массива (eax - частное, edx - остаток)
	mov [edi], ax

	add esp, 8
	pop ebp
	ret
main_f endp
END
