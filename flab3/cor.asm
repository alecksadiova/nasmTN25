%macro print_text 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

section .data
    enter_name db "Enter Name: ", 
    enter_namelen equ $ - enter_name

    enter_studnum db "Enter Student Number: ", 
    enter_studnumlen equ $ - enter_studnum

    enter_prog db "Enter Program: ", 
    enter_proglen equ $ - enter_prog

    title db "CERTIFICATE OF REGISTRATION", 10
    titlelen equ $ - title

    msg_name db "Name: "
    msg_namelen equ $ - msg_name

    msg_prog db "Program: "
    msg_proglen equ $ - msg_prog

    msg_studnum db "Student Number: "
    msg_studnumlen equ $ - msg_studnum

    subjects db 10, "SUBJECTS                                         UNITS", 10
             db "CCS0021   Information Management (LEC)              2", 10
             db "CCS0021L  Information Management (LAB)              1", 10
             db "CS0003    Computer Systems & Architecture           2", 10
             db "CS0003L   Computer Systems & Architecture (LAB)     2", 10
             db "CS0016    Network and Communications 2A             3", 10
             db "CS0070    Object Oriented Programming               2", 10
             db "CS0070L   Object Oriented Programming-LAB           1", 10
             db "GED0021   Specialized English Program 2             3", 10
             db "GED0083   College Physics 2 Lecture                 2", 10
    subjectslen equ $ - subjects

    enter_units db 10, "Enter total units: "
    enter_unitslen equ $ - enter_units

    enter_rate db "Enter price per unit: "
    enter_ratelen equ $ - enter_rate

    tuition_msg db 10, "Tuition Fee: PHP "
    tuition_msglen equ $ - tuition_msg

    fees db "Miscellaneous Fee: PHP 12305.00", 10
         db "ID Validation Fee: PHP 80.00", 10
         db "Computer Lab Fee (CCS0021): PHP 4008.00", 10
         db "Computer Lab Fee (CS0003): PHP 4008.00", 10
         db "Computer Lab Fee (CS0070): PHP 4008.00", 10
         db "Science Lab Fee (GED0083): PHP 4104.00", 10
         db "Specialized Network (CS0016): PHP 5264.00", 10
    feeslen equ $ - fees

    total_msg db "Total Assessment: PHP "
    total_msglen equ $ - total_msg

    invalid_msg db "Invalid input", 10
    invalid_msglen equ $ - invalid_msg

    misc dd 12305
    id_fee dd 80
    lab_fee dd 4008
    science_fee dd 4104
    network_fee dd 5264

    decimal db ".00", 10
    newline db 10
    digit db 0

section .bss
    input_name resb 100
    input_studnum resb 10
    input_prog resb 100
    num_input resb 20

    name_len resd 1
    studnum_len resd 1
    prog_len resd 1

    units resd 1
    rate resd 1
    tuition resd 1
    total resd 1

section .text
    global _start

_start:
    call display_studinfo
    call display_sub
    call input_compute
    call display_fees

    mov eax, 1
    xor ebx, ebx
    int 0x80

display_studinfo:

; name of student
    print_text enter_name, enter_namelen
    mov ecx, input_name
    mov edx, 100
    call read_input

    mov [name_len], eax

; student num
    print_text enter_studnum, enter_studnumlen
    mov ecx, input_studnum
    mov edx, 10
    call read_input

    mov [studnum_len], eax

; program
    print_text enter_prog, enter_proglen
    mov ecx, input_prog
    mov edx, 100
    call read_input

    mov [prog_len], eax
    ret

read_input:
    mov eax, 3                ; read input
    mov ebx, 0                ; keyboard
    int 0x80
    ret

display_sub:
    print_text subjects, subjectslen
    ret

input_compute:

; input total units
    print_text enter_units, enter_unitslen
    call read_number
    mov [units], eax

; input price per unit
    print_text enter_rate, enter_ratelen
    call read_number
    mov [rate], eax

; compute tuition
    mov eax, [units]
    mov ebx, [rate]
    imul eax, ebx              ; units x price
    mov [tuition], eax

; add other fees
    add eax, [misc]
    add eax, [id_fee]

    mov ebx, [lab_fee]
    imul ebx, 3               ; three lab fees
    add eax, ebx

    add eax, [science_fee]
    add eax, [network_fee]

    mov [total], eax
    ret

display_fees:
    print_text tuition_msg, tuition_msglen

    mov eax, [tuition]
    call print_number
    print_text decimal, 4

    print_text fees, feeslen

    print_text total_msg, total_msglen

    mov eax, [total]
    call print_number
    print_text decimal, 4
    ret

read_number:
    mov ecx, num_input
    mov edx, 20
    call read_input

    cmp eax, 1
    jle invalid_input

    mov edx, eax              ; characters left
    mov ecx, num_input
    mov eax, 0                ; start number at 0

convert_number:
    cmp edx, 0
    je invalid_input          ; no enter found

    mov ebx, 0
    mov bl, [ecx]             ; current character

    cmp bl, 10                ; is it enter?
    je number_done

    cmp bl, '0'
    jb invalid_input

    cmp bl, '9'
    ja invalid_input

    sub ebx, '0'              ; character to digit
    imul eax, 10              ; previous number x 10
    add eax, ebx              ; add current digit

    inc ecx                   ; next character
    dec edx                   ; one less character
    jmp convert_number

number_done:
    cmp eax, 0
    je invalid_input          ; reject zero
    ret                       ; return the number

; display number in eax
print_number:
    mov esi, 0                ; count digits
    mov ebx, 10

divide_number:
    mov edx, 0
    div ebx                   ; separate last digit

    push edx                  ; save digit
    inc esi

    cmp eax, 0
    jne divide_number

show_digits:
    pop edx                   ; get saved digit
    add dl, '0'               ; digit to character
    mov [digit], dl

    print_text digit, 1

    dec esi
    cmp esi, 0
    jne show_digits
    ret

invalid_input:
    print_text invalid_msg, invalid_msglen

    mov eax, 1
    mov ebx, 1
    int 0x80