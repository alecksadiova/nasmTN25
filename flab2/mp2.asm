section .data

    menu_label db "==================================", 10
    db "     DUNGEON OF THE LOST KING     ", 10
    db "==================================", 10
    db "               |>>>>              ", 10
    db "               |                  ", 10
    db "           _  _|_  _              ", 10
    db "          \.    .    /            ", 10
    db "           \:    .  /             ", 10
    db "            \.. .  /              ", 10
    db "            ||:    |              ", 10
    db "            ||:    |              ", 10
    db "            ||:    |              ", 10
    db "        ENTER IF YOU DARE!        ", 10
    db "==================================", 10
    menu_len equ $ - menu_label

    name db "Enter your hero name: "
    name_len equ $ - name

    msg db "Choose your character: ", 10
    msg_len equ $ - msg

    warrior_msg db "[1] Warrior", 10
    warrior_len equ $ - warrior_msg

    mage_msg db "[2] Mage", 10
    mage_len equ $ - mage_msg

    archer_msg db "[3] Archer", 10
    archer_len equ $ - archer_msg

    enter_choice db "Enter choice: "
    enter_choice_len equ $ - enter_choice

    invalid_msg db "Invalid input", 10
    invalid_len equ $ - invalid_msg

    welcome db "Welcome, "
    welcome_len equ $ - welcome

    warrior_name db "Warrior "
    warrior_name_len equ $ - warrior_name

    mage_name db "Mage "
    mage_name_len equ $ - mage_name

    archer_name db "Archer "
    archer_name_len equ $ - archer_name

    explore db "[1] Explore Dungeon", 10
    explore_len equ $ - explore 
    view_char db "[2] View Character Status", 10
    view_char_len equ $ - view_char
    potion db "[3] Use Character Potion", 10
    potion_len equ $ - potion
    view_inven db "[4] View Invntory", 10
    view_inven_len equ $ - view_inven
    exit_g db "[5] Exit Game", 10
    exit_g_len equ $ - exit_g

    room1 db "     ,       ,       ", 10
             "    / (.-""-.) \     ", 10
             "|\  \/        \/   /|", 10
             "| \ / =.   .=  \  / |", 10
             " \  \    ^     /   / ", 10
             "  \  '--------'   /  ", 10
             " A GOBLIN APPEARS!", 10
    


    newline db 10

section .bss
    name_input resb 100
    char_input resb 2
    name_input_len resd 1

    menu_input resb 2

section .text
    global _start

_start:

; display title
    mov eax, 4
    mov ebx, 1
    mov ecx, menu_label
    mov edx, menu_len
    int 0x80

; ask for name
    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, name_len
    int 0x80

; read name
    mov eax, 3
    mov ebx, 0
    mov ecx, name_input
    mov edx, 100
    int 0x80

    dec eax
    mov [name_input_len], eax

menu:
    call menu_choice

    cmp al, '1'
    je warrior

    cmp al, '2'
    je mage

    cmp al, '3'
    je archer

    jmp invalid


warrior:
    mov ecx, warrior_name
    mov edx, warrior_name_len
    jmp show_welcome


mage:
    mov ecx, mage_name
    mov edx, mage_name_len
    jmp show_welcome


archer:
    mov ecx, archer_name
    mov edx, archer_name_len
    jmp show_welcome


show_welcome:
    push ecx
    push edx

; display welcome
    mov eax, 4
    mov ebx, 1
    mov ecx, welcome
    mov edx, welcome_len
    int 0x80

; display character class
    pop edx
    pop ecx

    mov eax, 4
    mov ebx, 1
    int 0x80

; display hero name
    mov eax, 4
    mov ebx, 1
    mov ecx, name_input
    mov edx, [name_input_len]
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    jmp exit


invalid:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_msg
    mov edx, invalid_len
    int 0x80

    jmp menu


menu_choice:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, warrior_msg
    mov edx, warrior_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, mage_msg
    mov edx, mage_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, archer_msg
    mov edx, archer_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, enter_choice
    mov edx, enter_choice_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, char_input
    mov edx, 2
    int 0x80

    mov al, [char_input]

main_menu:
    call main_menu_choice

    cmp al, '1'
    je explore

    cmp al, '2'
    je view_char


    cmp al, '3'
    je potion

    cmp al, '4'
    je view_inven

    cmp al, '5'
    je exit

    jmp invalid

main_menu_choice:
    mov eax, 4
    mov ebx, 1
    mov ecx, explore
    mov edx, explore_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, view_char
    mov edx, view_char_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, potion
    mov edx, potion_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, view_inven
    mov edx, view_inven_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, exit_g
    mov edx, exit_g_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, menu_input
    mov edx, 2
    int 0x80

    mov al, [menu_input]
    ret

explore_dungeon:


character_status:

use_potion:

view_invetory:

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80