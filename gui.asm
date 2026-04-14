loadgui:
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
    mov dl, 59
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
    lea di, appname

guiappselect:
    mov ah, 0
    int 0x16
    cmp ah, 0x1C
    je readapp
    cld
    stosb
    mov ah, 0x0E
    int 0x10
    jmp guiappselect

readapp:
    mov si, appname
    lodsb
    cmp al, "c"
    je checkcli1
    jne loadgui

checkcli1:
    lodsb
    cmp al, "l"
    je checkcli2
    jne loadgui

checkcli2:
    lodsb
    cmp al, "i"
    je clicommand
    jne loadgui

clicommand:
    lea di, appname
    mov al, 0
    mov cx, 3
    rep stosb
    jmp loadcli

uimsg1 db "GUIyetCLI OS v0.0.1", 0
uimsg2 db " Enter app name to launch: ", 0

