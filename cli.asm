loadcli:
    mov ax, 0x03
    int 0x10
    mov si, climsg1
    mov ah, 0x0E
    call print
    lea di, appname
    jmp cliinput

cliinput:
    mov ah, 0
    int 0x16
    cmp ah, 0x1C
    je read
    cld
    stosb
    mov ah, 0x0E
    int 0x10
    jmp cliinput

read:
    mov si, appname
    lodsb
    cmp al, "g"
    je checkgui1
    cmp al, "h"
    je checkhelp1
    mov si, climsg2
    mov ah, 0x0E
    call print
    jmp cliinput

checkgui1:
    lodsb
    cmp al, "u"
    je checkgui2

checkgui2:
    lodsb
    cmp al, "i"
    je guicommand

guicommand:
    lea di, appname
    mov al, 0
    mov cx, 3
    rep stosb
    jmp loadgui

checkhelp1:
    lodsb
    cmp al, "e"
    je checkhelp2

checkhelp2:
    lodsb
    cmp al, "l"
    je checkhelp3

checkhelp3:
    lodsb
    cmp al, "p"
    je helpcommand

helpcommand:
    lea di, appname
    mov al, 0
    mov cx, 3
    rep stosb
    mov si, helpmsg
    mov ah, 0x0E
    call print
    lea di, appname
    jmp read

climsg1 db "GUIyetCLI OS Command Line Interface Version 0.0.1.", 13, 10, "Type 'gui' to launch in graphical user interface mode.", 13, 10, ">> ", 0
climsg2 db 13, 10, ">> ", 0
helpmsg db 13, 10, "help: Display this message.", 13, 10, "gui:  Launches the graphical user interface.", 0
