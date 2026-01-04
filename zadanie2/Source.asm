.686P
.MODEL FLAT, C


.CODE
main_f proc
	push ebp
	mov ebp, esp
	sub esp, 24
	mov esi, [ebp + 8]				; arr
	mov ecx, [ebp + 12]				; n
	xor eax, eax
	mov ax, [esi]					; a[0]

	mov dword ptr [ebp - 4], 0		; res_start
	mov dword ptr [ebp - 8], 1		; res_len
	mov dword ptr [ebp - 12], 0		; res_sum
	mov dword ptr [ebp - 16], 0		; cur_start
	mov dword ptr [ebp - 20], 1		; cur_len
	mov dword ptr [ebp - 24], eax	; cur_sum

	xor eax, eax
	add esi, 2
	dec ecx

i_loop:
	test ecx, ecx
	jz loop_end
	xor eax, eax  
	mov ax, [esi]
	xor ebx, ebx  
	mov bx, [esi - 2]
	cmp ax, bx
	jl posl_prod					; a[i] < a[i-1] - последовательность продолжается
	mov ebx, [ebp - 20]
	cmp	ebx, [ebp - 8]				; иначе сравниваем с результатом
	jg reset_res
	mov ebx, dword ptr [ebp - 20]
	add dword ptr [ebp - 16], ebx	; cur_start
	mov dword ptr [ebp - 20], 1		; cur_len
	mov dword ptr [ebp - 24], eax	; cur_sum
	jmp skip
posl_prod:
	inc dword ptr [ebp - 20]		; cur_len++
	add dword ptr [ebp - 24], eax	; cur_sum += a[i]
	jmp skip
reset_res:
	mov ebx, dword ptr [ebp - 20]
	mov edx, ebx
	mov dword ptr [ebp - 8], ebx	; res_len = cur_len
	mov ebx, dword ptr [ebp - 16]
	mov dword ptr [ebp - 4], ebx	; res_start = cur_start
	mov ebx, dword ptr [ebp - 24]
	mov dword ptr [ebp - 12], ebx	; res_sum = cur_sum
	add dword ptr [ebp - 16], edx	; cur_start += old cur_len
	mov dword ptr [ebp - 20], 1
	mov dword ptr [ebp - 24], eax
skip:
	add esi, 2
	dec ecx
	jmp i_loop
loop_end:
	mov ebx, [ebp - 20]
	cmp	ebx, [ebp - 8]
	jg reset_res_last
	jmp finish
reset_res_last:
	mov ebx, dword ptr [ebp - 20]
	mov dword ptr [ebp - 8], ebx	; res_len = cur_len
	mov ebx, dword ptr [ebp - 16]
	mov dword ptr [ebp - 4], ebx	; res_start = cur_start
	mov ebx, dword ptr [ebp - 24]
	mov dword ptr [ebp - 12], ebx	; res_sum = cur_sum
finish:
	mov eax, [ebp+16]     ; &len
	mov ebx, dword ptr [ebp - 8]
	mov [eax], ebx
	mov eax, [ebp+20]     ; &start
	mov ebx, dword ptr [ebp - 4]
	mov [eax], ebx
	
	mov esp, ebp
	pop ebp
	ret

main_f endp
END