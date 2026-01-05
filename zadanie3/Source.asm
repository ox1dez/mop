.686P
.MODEL FLAT, C

; параметры: +8 исходный массив, +12 результат массив
; локальные переменные: 

.DATA
	d227 dd 227
	d2   dd 2

.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 4							; k = [ebp - 4]
	mov dword ptr [ebp-4], 0
	mov esi, [ebp + 8]					; исходный массив
	mov edi, [ebp + 12]					; результирующий массив
	mov ecx, [ebp + 16]					; n
	mov ebx, -32768						; M
i_loop:
	test ecx, ecx
	jz loop_end
	xor eax, eax
	movsx eax, word ptr [esi]						; ax - a[i]
	cmp eax, ebx
	jle skip
	cdq
	idiv d227							; деление - в дх остаток, в ах частное
	cmp edx, 0
	jne skip
	movsx ebx, word ptr [esi]
skip:
	add esi, 2
	dec ecx
	jmp i_loop
loop_end:
	xor esi, esi
	xor ecx, ecx
	mov esi, [ebp + 8]					; исходный массив
	mov ecx, [ebp + 16]					; n
x_loop:
	cmp ecx, 1
	je finish
	xor eax, eax
	xor edx, edx
	movsx eax, word ptr [esi]			; a[i]
	movsx edx, word ptr [esi+2]			; a[i+1]
	cmp eax, ebx
	jg greater
	cmp edx, ebx
	jg greater
	jmp x_skip
greater:
	add eax, edx
	xor edx, edx
	cdq
	idiv d2
	mov [edi], ax						; частное от деления (2 байта)
	add edi, 2
	inc dword ptr [ebp - 4]
x_skip:
	add esi, 2
	dec ecx
	jmp x_loop
finish:
	mov eax, [ebp - 4]					; return k
	mov esp, ebp
	pop ebp
	ret
main_f endp
END