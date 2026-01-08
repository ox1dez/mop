.686P
.MODEL FLAT, C

; параметры: +8 исходный массив, +12 размер массива
; локальные переменные: 
; найти M - средн. арифметическое чисел кратных 7
; Умножить все элементы на M
.DATA
	d7 dw 7
	d2  dd 2

.CODE
main_f proc
	push ebp
	mov ebp, esp
	mov esi, [ebp + 8]						; arr
	mov ecx, [ebp + 12]						; n
	sub esp, 8
	mov dword ptr [ebp - 4], 0				; sum
	mov dword ptr [ebp - 8], 0				; count
	xor eax, eax
	xor edx, edx
i_loop:
	test ecx, ecx
	jz i_loop_end
	mov ax, [esi]
	cwd
	idiv d7
	cmp dx, 0
	jne i_skip
	movsx eax, word ptr [esi]
	add dword ptr [ebp - 4], eax
	inc dword ptr [ebp - 8]
i_skip:
	add esi, 2
	dec ecx
	jmp i_loop
i_loop_end:
	mov eax, dword ptr [ebp - 4]
	cdq
	idiv dword ptr [ebp - 8]
	mov ebx, eax							; ebx = M
	xor eax, eax
	mov esi, [ebp + 8]						; arr
	mov ecx, [ebp + 12]						; n
x_loop:
	test ecx, ecx
	jz finish
	add [esi], ebx
	add esi, 2
	dec ecx
	jmp x_loop
finish:
	mov esp, ebp
	pop ebp
	ret
main_f endp
END