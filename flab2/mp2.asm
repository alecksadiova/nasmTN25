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

    potion db "[3] Use Health Potion", 10
    potion_len equ $ - potion

    view_inven db "[4] View Inventory", 10
    view_inven_len equ $ - view_inven

    exit_g db "[5] Exit Game", 10
    exit_g_len equ $ - exit_g

    room1 db "     ,       ,       ", 10
    db '    / (.-""-.) \     ', 10
    db "|\  \/        \/   /|", 10
    db "| \ / =.   .=  \  / |", 10
    db " \  \    ^     /   / ", 10
    db "  \  '--------'   /  ", 10
    db " A GOBLIN APPEARS!", 10
    room1_len equ $ - room1

    goblin_op1 db "[1] Attack", 10
    goblin_op1_len equ $ - goblin_op1

    goblin_op2 db "[2] Defend", 10
    goblin_op2_len equ $ - goblin_op2

    goblin_op3 db "[3] Use Potion", 10
    goblin_op3_len equ $ - goblin_op3

    goblin_op4 db "[4] Run", 10
    goblin_op4_len equ $ - goblin_op4

    goblin_done db "Goblin defeated!", 10
    goblin_done_len equ $ - goblin_done

    room2 db "     ____________     ", 10
          db "    /___________/|    ", 10
          db "   |  ________ | |    ", 10
          db "   | |   ?    || |    ", 10
          db "   | |________|| /    ", 10
          db "   | __________|/     ", 10
    room2_len equ $ - room2

    treasure_op1 db "[1] Open Chest", 10
    treasure_op1_len equ $ - treasure_op1

    treasure_op2 db "[2] Leave Chest", 10
    treasure_op2_len equ $ - treasure_op2

    room3 db "            / \  // \  ", 10
          db "   |\___/|      \      ", 10
          db "   /o   o \      |     ", 10
          db "  /   ^    \    /      ", 10
          db " /  \    /  \  /       ", 10
          db " \___________\/        ", 10
          db " THE DRAGON AWAKENS!", 10
    room3_len equ $ - room3

    victory db "VICTORY!", 10
    victory_len equ $ - victory

    congrats db "CONGRATULATIONS, "
    congrats_len equ $ - congrats

    u_defeated db "You defeated the dragon and escaped!", 10
    u_defeated_len equ $ - u_defeated

    f_gold db "Final Gold: "
    f_gold_len equ $ - f_gold

    remain_hel db "Remaining Health: "
    remain_hel_len equ $ - remain_hel

    hero db "YOU ARE A HERO!", 10
    hero_len equ $ - hero

    game_over db "GAME OVER", 10
    game_over_len equ $ - game_over

    fallen_hero db "Your hero has fallen.", 10
    fallen_hero_len equ $ - fallen_hero

    undefeated db "The dungeon remains undefeated.", 10
    undefeated_len equ $ - undefeated

    next_time db "BETTER LUCK NEXT TIME!", 10
    next_time_len equ $ - next_time

    unfinished db "This option is not added yet.", 10
    unfinished_len equ $ - unfinished

    health_msg db "Health: "
    health_msg_len equ $ - health_msg

    attack_msg db "Attack: "
    attack_msg_len equ $ - attack_msg

    potion_used db "Potion used. Health: "
    potion_used_len equ $ - potion_used

    no_potion_msg db "No potions left.", 10
    no_potion_len equ $ - no_potion_msg

    gold_msg db "Gold: "
    gold_msg_len equ $ - gold_msg

    potions_msg db "Potions: "
    potions_msg_len equ $ - potions_msg

    goblin_health dd 30
    dragon_health dd 60

    digits db "00"
    hundred db "100"

    current_room dd 1

    newline db 10

section .bss
    name_input resb 100
    char_input resb 2
    name_input_len resd 1
    menu_input resb 2

    health resd 1
    attack_damage resd 1

    max_health resd 1
    potions_left resd 1
    gold resd 1

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
    mov eax, 100
    mov [health], eax
    mov [max_health], eax       ;starting health limit

    mov eax, 20
    mov [attack_damage], eax

    mov eax, 2
    mov [potions_left], eax     ;2 potions

    mov ecx, warrior_name
    mov edx, warrior_name_len
    jmp show_welcome


mage:
    mov eax, 70
    mov [health], eax
    mov [max_health], eax

    mov eax, 30
    mov [attack_damage], eax

    mov eax, 3
    mov [potions_left], eax      ;3 potions

    mov ecx, mage_name
    mov edx, mage_name_len
    jmp show_welcome


archer:
    mov eax, 85
    mov [health], eax
    mov [max_health], eax

    mov eax, 25
    mov [attack_damage], eax

    mov eax, 2
    mov [potions_left], eax     ;2 potions

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

    jmp main_menu


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
    ret


main_menu:
    call main_menu_choice

    cmp al, '1'
    je explore_dungeon

    cmp al, '2'
    je character_status

    cmp al, '3'
    je use_potion

    cmp al, '4'
    je view_inventory

    cmp al, '5'
    je exit

    jmp invalid_main


invalid_main:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_msg
    mov edx, invalid_len
    int 0x80

    jmp main_menu


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

    mov eax, 4
    mov ebx, 1
    mov ecx, enter_choice
    mov edx, enter_choice_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, menu_input
    mov edx, 2
    int 0x80

    mov al, [menu_input]
    ret


goblin:
    mov eax, 4
    mov ebx, 1
    mov ecx, room1
    mov edx, room1_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_op1
    mov edx, goblin_op1_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_op2
    mov edx, goblin_op2_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_op3
    mov edx, goblin_op3_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_op4
    mov edx, goblin_op4_len
    int 0x80

; ask for choice
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_choice
    mov edx, enter_choice_len
    int 0x80

; read choice
    mov eax, 3
    mov ebx, 0
    mov ecx, char_input
    mov edx, 2
    int 0x80

    mov al, [char_input]
    ret


treasure_room:
    mov eax, 4
    mov ebx, 1
    mov ecx, room2
    mov edx, room2_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, treasure_op1
    mov edx, treasure_op1_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, treasure_op2
    mov edx, treasure_op2_len
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
    ret


explore_dungeon:
    mov eax, [current_room]

    cmp eax, 2
    je treasure_menu

    cmp eax, 3
    je dragon_room

    mov eax, [goblin_health]
    cmp eax, 0
    jle goblin_defeated

    call goblin

    cmp al, '1'
    je attack_goblin

    cmp al, '2'
    je defend_goblin

    cmp al, '3'
    je potion_goblin

    cmp al, '4'
    je main_menu

    jmp invalid_battle


invalid_battle:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_msg
    mov edx, invalid_len
    int 0x80

    jmp explore_dungeon


attack_goblin:
    mov eax, [goblin_health]
    mov ebx, [attack_damage]
    sub eax, ebx
    mov [goblin_health], eax

    cmp eax, 0
    jle goblin_defeated

; living goblin attacks back
    mov eax, [health]
    sub eax, 10
    mov [health], eax

    cmp eax, 0
    jle hero_defeated

    jmp explore_dungeon


defend_goblin:
    mov eax, [health]
    sub eax, 5             ; reduced goblin damage
    mov [health], eax

    cmp eax, 0
    jle hero_defeated

    jmp explore_dungeon


potion_goblin:
    call heal_player
    jmp explore_dungeon

goblin_defeated:
    mov eax, 0
    mov [goblin_health], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_done
    mov edx, goblin_done_len
    int 0x80

    mov eax, 2
    mov [current_room], eax    ; advance to room 2

    jmp treasure_menu

hero_defeated:
    mov eax, 0
    mov [health], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, game_over
    mov edx, game_over_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, fallen_hero
    mov edx, fallen_hero_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, undefeated
    mov edx, undefeated_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, next_time
    mov edx, next_time_len
    int 0x80

    jmp exit


character_status:
; display health
    mov eax, 4
    mov ebx, 1
    mov ecx, health_msg
    mov edx, health_msg_len
    int 0x80

    mov eax, [health]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

; display attack
    mov eax, 4
    mov ebx, 1
    mov ecx, attack_msg
    mov edx, attack_msg_len
    int 0x80

    mov eax, [attack_damage]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    jmp main_menu

use_potion:
    call heal_player
    jmp main_menu

view_inventory:
; show gold
    mov eax, 4
    mov ebx, 1
    mov ecx, gold_msg
    mov edx, gold_msg_len
    int 0x80

    mov eax, [gold]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

; show potions
    mov eax, 4
    mov ebx, 1
    mov ecx, potions_msg
    mov edx, potions_msg_len
    int 0x80

    mov eax, [potions_left]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    jmp main_menu

print_number:
    cmp eax, 100
    jne prepare_digits

    mov ecx, hundred
    mov edx, 3
    jmp print_result

prepare_digits:
    mov ebx, 0             ; tens count

count_tens:
    cmp eax, 10
    jl save_digits

    sub eax, 10            ; remove one ten
    inc ebx                ; count it
    jmp count_tens

save_digits:
    add bl, '0'            ; tens to character
    add al, '0'            ; ones to character

    mov [digits], bl
    mov [digits + 1], al

    mov ecx, digits
    mov edx, 2

    cmp bl, '0'
    jne print_result

    inc ecx                ; skip leading zero
    mov edx, 1

print_result:
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret


heal_player:
    mov eax, [potions_left]

    cmp eax, 0
    jle no_potions          ; none left

    dec eax                 ; use one potion
    mov [potions_left], eax

    mov eax, [health]
    add eax, 20             ; restore 20 health

    cmp eax, [max_health]
    jle save_health         ; within limit

    mov eax, [max_health]   ; cap health

save_health:
    mov [health], eax       ; save new health

    mov eax, 4
    mov ebx, 1
    mov ecx, potion_used
    mov edx, potion_used_len
    int 0x80

    mov eax, [health]
    call print_number       ; show current health

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

no_potions:
    mov eax, 4
    mov ebx, 1
    mov ecx, no_potion_msg
    mov edx, no_potion_len
    int 0x80
    ret

treasure_menu:
    call treasure_room

    cmp al, '1'
    je open_chest

    cmp al, '2'
    je leave_chest

    jmp invalid_battle


open_chest:
    mov eax, [gold]
    add eax, 50                ; collect treasure
    mov [gold], eax

    jmp leave_chest


leave_chest:
    mov eax, 3
    mov [current_room], eax    ; advance to room 3

    jmp dragon_room

dragon_room:
; show dragon
    mov eax, 4
    mov ebx, 1
    mov ecx, room3
    mov edx, room3_len
    int 0x80

; same battle options as goblin
    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_op1
    mov edx, goblin_op1_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_op2
    mov edx, goblin_op2_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_op3
    mov edx, goblin_op3_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, goblin_op4
    mov edx, goblin_op4_len
    int 0x80

; ask for choice
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_choice
    mov edx, enter_choice_len
    int 0x80

; read choice
    mov eax, 3
    mov ebx, 0
    mov ecx, char_input
    mov edx, 2
    int 0x80

    mov al, [char_input]

    cmp al, '1'
    je attack_dragon

    cmp al, '2'
    je defend_dragon

    cmp al, '3'
    je potion_dragon

    cmp al, '4'
    je main_menu               ; run

    jmp invalid_dragon


attack_dragon:
    mov eax, [dragon_health]
    mov ebx, [attack_damage]
    sub eax, ebx               ; damage dragon
    mov [dragon_health], eax

    cmp eax, 0
    jle dragon_defeated

; surviving dragon attacks back
    mov eax, [health]
    sub eax, 15
    mov [health], eax

    cmp eax, 0
    jle hero_defeated

    jmp dragon_room


defend_dragon:
    mov eax, [health]
    sub eax, 10                ; 15 damage minus 5
    mov [health], eax

    cmp eax, 0
    jle hero_defeated

    jmp dragon_room


potion_dragon:
    call heal_player
    jmp dragon_room


invalid_dragon:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_msg
    mov edx, invalid_len
    int 0x80

    jmp dragon_room


dragon_defeated:
    mov eax, 0
    mov [dragon_health], eax

; show victory
    mov eax, 4
    mov ebx, 1
    mov ecx, victory
    mov edx, victory_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, congrats
    mov edx, congrats_len
    int 0x80

; show hero name
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

    mov eax, 4
    mov ebx, 1
    mov ecx, u_defeated
    mov edx, u_defeated_len
    int 0x80

; show final gold
    mov eax, 4
    mov ebx, 1
    mov ecx, f_gold
    mov edx, f_gold_len
    int 0x80

    mov eax, [gold]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

; show remaining health
    mov eax, 4
    mov ebx, 1
    mov ecx, remain_hel
    mov edx, remain_hel_len
    int 0x80

    mov eax, [health]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, hero
    mov edx, hero_len
    int 0x80

    jmp exit

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80