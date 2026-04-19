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
    cmp al, "f"
    je checkfile1
    jne loadgui

checkfile1:
    lodsb
    cmp al, "i"
    je checkfile2
    jne loadgui

checkfile2:
    lodsb
    cmp al, "l"
    je checkfile3
    jne loadgui

checkfile3:
    lodsb
    cmp al, "e"
    je filecommand
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

filecommand:
    mov ah, 0x02
    mov bh, 0
    mov dh, 0
    mov dl, 0
    int 0x10
    mov ah, 0x06
    mov al, 0
    mov bh, 0xF0
    mov cx, 0
    mov dx, 0x184F
    int 0x10
    mov ah, 0x06
    mov bh, 0x70
    mov ch, 0
    mov cl, 0
    mov dh, 0
    mov dl, 0x4F
    int 0x10
    mov si, filewindow
    mov ah, 0x0E
    call print
    lea di, filename

fileselect:
    mov ah, 0
    int 0x16
    cmp ah, 0x1C
    je readfile
    cld
    stosb
    mov ah, 0x0E
    int 0x10
    jmp fileselect

readfile:
    mov si, filename
    lodsb
    cmp al, "a"
    je checkaboutfile1
    cmp al, "o"
    je checkosfile1
    cmp al, "&"
    je loadgui
    jne filecommand

checkosfile1:
    lodsb
    cmp al, "s"
    je checkosfile2
    jne filecommand

checkosfile2:
    lodsb
    cmp al, "."
    je checkosfile3
    jne filecommand

checkosfile3:
    lodsb
    cmp al, "i"
    je checkosfile4
    jne filecommand

checkosfile4:
    lodsb
    cmp al, "m"
    je checkosfile5
    jne filecommand

checkosfile5:
    lodsb
    cmp al, "g"
    je printos
    jmp filecommand

printos:
    mov si, osbin
    mov ah, 0x0E
    call print
    mov ah, 0
    int 0x16
    cmp ah, 0x1C
    je filecommand
    jmp printos

checkaboutfile1:
    lodsb
    cmp al, "b"
    je checkaboutfile2
    jne filecommand

checkaboutfile2:
    lodsb
    cmp al, "o"
    je checkaboutfile3
    jne filecommand

checkaboutfile3:
    lodsb
    cmp al, "u"
    je checkaboutfile4
    jne filecommand

checkaboutfile4:
    lodsb
    cmp al, "t"
    je checkaboutfile5
    jne filecommand

checkaboutfile5:
    lodsb
    cmp al, "."
    je checkaboutfile6
    jne filecommand

checkaboutfile6:
    lodsb
    cmp al, "t"
    je checkaboutfile7
    jne filecommand

checkaboutfile7:
    lodsb
    cmp al, "x"
    je checkaboutfile8
    jne filecommand

checkaboutfile8:
    lodsb
    cmp al, "t"
    je printabout
    jmp filecommand

printabout:
    mov si, abouttxt
    mov ah, 0x0E
    call print
    mov ah, 0
    int 0x16
    cmp ah, 0x1C
    je filecommand
    jmp printabout

uimsg1 db "GUIyetCLI OS v0.0.1", 0
uimsg2 db " Enter app name to launch: ", 0
filewindow db " File", 13, 10, " Your files (Read-only):", 13, 10, " about.txt", 13, 10, " os.img", 13, 10, 13, 10, " Enter filename to read (Press '&' to exit): ", 0
abouttxt db 13, 10, 13, 10, " File contents:", 13, 10, " 1 Hello world! Thank you for using GUIyetCLI OS!", 13, 10, " 2 You are currently using version 0.0.1.", 13, 10, 13, 10, " Press 'enter' to return.", 0
osbin db 13, 10, 13, 10, " File contents cannot be displayed (Binary content)", 13, 10, " Press 'enter' to return.", 0

