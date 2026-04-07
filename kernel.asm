[BITS 16]
[ORG 0x7E00]

section .bss
appname resb 64

section .text
start:
    mov si, banner
    mov ah, 0x0E
    call print
    mov si, kernelmsg1
    mov ah, 0x0E
    call print

selectmode:
    mov ah, 0
    int 0x16
    cmp al, 0x31
    je loadcli
    cmp al, 0x32
    je loadcomputer

loadcli:
    mov ax, 0x03
    int 0x10
    mov si, climsg1
    mov ah, 0x0E
    call print
    jmp cliinput

cliinput:
    mov ah, 0
    int 0x16
    cmp ah, 0x1C
    je read
    stosb
    mov ah, 0x0E
    int 0x10
    jmp cliinput

read:
    mov si, climsg2
    mov ah, 0x0E
    call print
    jmp cliinput

loadcomputer:
    mov ah, 0x06
    mov al, 0
    mov bh, 0x90
    mov cx, 0
    mov dx, 0x184F
    int 0x10
    mov ah, 0x06
    mov bh, 0xF0
    mov ch, 24
    mov cl, 0
    mov dh, 24
    mov dl, 0x4F
    int 0x10
    mov ah, 0x02
    mov bh, 0
    mov dh, 0
    mov dl, 0
    int 0x10
    mov ah, 0x0E
    mov si, banner
    call print
    mov ah, 0x02
    mov bh, 0
    mov dh, 24
    mov dl, 60
    int 0x10
    mov si, uimsg1
    mov ah, 0x0E
    call print
    mov ah, 0x02
    mov bh, 0
    mov dh, 24
    mov dl, 0
    int 0x10
    mov si, uimsg2
    mov ah, 0x0E
    call print

guiappselect:
    mov di, appname
    mov ah, 0
    int 0x16
    cmp ah, 0x1C
    je readapp
    mov ah, al
    stosb
    mov ah, 0x0E
    int 0x10
    jmp guiappselect

readapp:
    mov si, appname
    mov di, cliapp
    mov cx, 3
    repe cmpsb
    jne loadcomputer
    jmp loadcli

print:
    lodsb
    cmp al, 0
    je return
    int 0x10
    jmp print

return:
    ret

halt:
    hlt

section .data
kernelmsg1 db "Welcome to GUIyetCLI OS!", 13, 10, "Please select a mode to boot in.", 13, 10, "1: Command line interface", 13, 10, "2: Graphical user interface", 13, 10, "Enter your choice: ", 0
uimsg1 db "GUIyetCLI OS v0.0.1", 0
uimsg2 db "Enter app name to launch: ", 0
climsg1 db "GUIyetCLI OS Command Line Interface Version 0.0.1.", 13, 10, "Type 'gui' to launch in graphical user interface mode.", 13, 10, ">> ", 0
climsg2 db 13, 10, ">> ", 0
cliapp db "cli"
banner db 219,219,219,219,219,219,219,219,32,219,219,32,32,32,32,219,219,32,219,219,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,219,219,32,32,32,32,219,219,219,219,219,219,219,219,32,219,219,32,32,32,32,32,32,32,219,219,13,10,219,219,32,32,32,32,32,32,32,219,219,32,32,32,32,219,219,32,219,219,32,219,219,32,32,32,32,219,219,32,219,219,219,219,219,219,219,219,32,219,219,219,219,219,219,219,219,32,219,219,32,32,32,32,32,32,32,219,219,32,32,32,32,32,32,32,219,219,13,10,219,219,32,32,219,219,219,219,32,219,219,32,32,32,32,219,219,32,219,219,32,32,219,219,32,32,219,219,32,32,219,219,220,220,220,220,220,219,32,32,32,32,219,219,32,32,32,32,219,219,32,32,32,32,32,32,32,219,219,32,32,32,32,32,32,32,219,219,13,10,219,219,32,32,32,32,219,219,32,219,219,32,32,32,32,219,219,32,219,219,32,32,32,219,219,219,219,32,32,32,219,219,32,32,32,32,32,32,32,32,32,32,219,219,32,32,32,32,219,219,32,32,32,32,32,32,32,219,219,32,32,32,32,32,32,32,219,219,13,10,219,219,219,219,219,219,219,219,32,219,219,219,219,219,219,219,219,32,219,219,32,32,32,32,219,219,32,32,32,32,219,219,219,219,219,219,219,219,32,32,32,32,219,219,32,32,32,32,219,219,219,219,219,219,219,219,32,219,219,219,219,219,219,219,219,32,219,219,13,10,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,219,219,13,10,0
