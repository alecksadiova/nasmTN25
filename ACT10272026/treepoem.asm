%macro print_text 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

section .data

tree db "            I              ", 10
     db "          wrote            ", 10
     db "          a poem           ", 10
     db "       in the shape        ", 10
     db "      of a Christmas       ", 10
     db "    tree but then forgot    ", 10
     db " to water it and only a few", 10
     db "           days            ", 10
     db "           later           ", 10
     treelen equ $ - tree

leaf db "              there", 10
     db "       were", 10
     db "                  words", 10
     db " all", 10
     db "               over", 10
     db "     the", 10
     db "                           carpet", 10
     leaflen equ $ - leaf

section .text
    global _start
    
_start:
    call tree_top
    call leaf_bottom

    mov eax, 1
    xor ebx, ebx
    int 0x80

tree_top:
    print_text tree, treelen
    ret

leaf_bottom:
    print_text leaf, leaflen
    ret