%include "syscalls.asm"

global _start

section .data
message: db "Enter the first number: "
message_length: equ $-message
message2: db "Enter the second number: "
message2_length: equ $-message2
message3: db "The sum is: "
message3_len: equ $ - message3

section .bss
number1 resq 1
number2 resq 1
sum resq 1

section .text
_start:
    write message, message_length
    read number1, 8
    mov r8, rax
    dec r8
    write message2, message2_length
    read number2, 8
    mov r10, rax
    dec r10
    call find_sum
    mov rax, r9
    call convert_int_to_str
    ; call make_string_from_stack
    write message3, message3_len
    write sum, 8
    
    exit 0
convert_int_to_str:
    ; lea rbx, [rax]
    xor rbx, rbx
    xor rdx, rdx
    mov r8, 10              ;THE BUG IS IN HERE. YOU ARE CONVERTING FROM RIGHT TO LEFT.
    div r8
    add rdx, 0x30
    push rdx
    test rax, rax
    jz string_builder
    jmp convert_int_to_str

string_builder:
    xor rcx, rcx
    
    jmp make_string_from_stack
convert_str_to_int:
    
    mov dl, byte [rax+rcx]
    sub rdx, '0'
    imul rbx, rbx, 10
    add rbx,rdx
    inc rcx
    cmp r10, rcx
    jz done
    jmp convert_str_to_int
find_sum:
    xor rbx, rbx
    xor rcx,rcx
    xor rdx,rdx
    lea rax, [number1]
    xchg r10, r8
    call convert_str_to_int
    mov r9, rbx
    lea rax, [number2]
    xor rbx, rbx
    xor rcx, rcx
    xor rdx,rdx
    xchg r10, r8
    call convert_str_to_int
    add r9, rbx
    jmp done

make_string_from_stack:
     ;copy the string into the sum
    
    pop rax
    cmp rax, 0x39
    jg push_back_and_done
    mov [sum+rcx], al
    inc rcx
    jmp make_string_from_stack
push_back_and_done:
    push rax
    jmp done
done:
        ret
;Works on same digits but not different