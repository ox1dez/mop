.686P
.MODEL FLAT, C

; параметры: +8 исходный массив, +12 размер массива, +16 результат массив
; локальные переменные: 

.DATA
	d23 dw 23
	d2  dd 2

.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 12
	mov esi, [ebp + 8]							; arr
	mov ecx, [ebp + 12]							; n
	mov edi, [ebp + 16]							; res
	mov dword ptr [ebp - 4], 0					; sum
	mov dword ptr [ebp - 8], 0					; count
	mov dword ptr [ebp - 12], 0					; K = count(x)
	xor ebx, ebx								; M = sum / count
i_loop:
	test ecx, ecx
	jz i_loop_end
	mov ax, [esi]
	cwd											; ax -> dx:ax (rashiryaem) 32
	idiv d23
	cmp dx, 0									; a[i] % 23 == 0 ?
	jne i_skip
	movsx eax, word ptr [esi]
	add dword ptr [ebp - 4], eax
	inc dword ptr [ebp - 8]
i_skip:
	add esi, 2
	dec ecx
	jmp i_loop
i_loop_end:
	mov eax, dword ptr [ebp - 4]				; eax = sum
	cdq											; eax -> edx:eax (rashiryaem) 64
	idiv dword ptr [ebp - 8]
	mov ebx, eax								; ebx = M
	xor eax, eax
	mov esi, [ebp + 8]							; arr
	mov ecx, [ebp + 12]							; n
x_loop:
	test ecx, ecx
	jz finish
	movsx eax, word ptr [esi]
	cmp eax, ebx
	jle greater
	jmp x_skip
greater:
	mov [edi], ax
	add edi, 2
	inc dword ptr [ebp - 12]
x_skip:
	add esi, 2
	dec ecx
	jmp x_loop

finish:
	mov eax, dword ptr [ebp - 12]
	mov esp, ebp
	pop ebp
	ret

main_f endp
END