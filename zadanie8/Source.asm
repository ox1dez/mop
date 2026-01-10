.686P
.MODEL FLAT, C

.DATA

.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 8
	mov dword ptr [ebp - 4], 0					; peek_sum
	mov dword ptr [ebp - 8], 0					; peek_count
	mov esi, [ebp + 8]							; n
	mov ecx, [ebp + 12]							; len
	xor eax, eax
first:
	movsx eax, word ptr [esi]							; a[0]
	cmp ax, [esi + 2]					
	jle	first_end
	add dword ptr [ebp - 4], eax
	inc dword ptr [ebp - 8]
first_end:
	add esi, 2
	dec ecx
i_loop:
	cmp ecx, 1
	je last
	movsx eax, word ptr [esi]							; a[i]
	cmp ax, [esi + 2]
	jle skip
	cmp ax, [esi - 2]
	jle skip
	add dword ptr [ebp - 4], eax
	inc dword ptr [ebp - 8]
skip:
	add esi, 2
	dec ecx
	jmp i_loop
last:
	movsx eax, word ptr [esi]							; a[-1]
	cmp ax, [esi - 2]
	jle i_loop_end
	add dword ptr [ebp - 4], eax
	inc dword ptr [ebp - 8]
i_loop_end:
	; eax - сумма
	mov eax, dword ptr [ebp - 4]
	cdq
	idiv dword ptr [ebp - 8]					; edx:eax / count
	mov esi, [ebp + 8]							; n
	mov ecx, [ebp + 12]							; len
x_loop:
	test ecx, ecx
	jz finish
	movsx edx, word ptr [esi]
	cmp edx, eax								; == secret key?
	je x_skip
	mov word ptr [esi], 0
x_skip:
	add esi, 2
	dec ecx
	jmp x_loop
finish:
	add esp, 8
	pop ebp
	ret

main_f endp
END