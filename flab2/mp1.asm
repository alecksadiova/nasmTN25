section .data
welcome db "=======================================", 0xA
        db "THE MYSTIC ZODIAC ORACLE", 0xA
        db "=======================================", 0xA
welcomelen equ $ - welcome
 
section .text
    global _start
 
_start:
mov eax, 4
mov eax, 1
mov ecx, welcome
mov edx, welcomelen
int 0x80  
 
mov eax, 1
mov ebx, 0
int 0x80
