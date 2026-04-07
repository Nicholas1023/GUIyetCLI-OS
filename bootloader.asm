[BITS 16]
[ORG 0x7C00]

start:
    mov ax, 0x03
    int 0x10
    mov si, bootmsg
    mov ah, 0x0E

loop:
    lodsb
    cmp al, 0
    je boot
    int 0x10
    jmp loop

boot:
    mov ah, 0x86
    mov cx, 0x0F
    mov dx, 0x4240
    int 0x15
    mov ax, 0x03
    int 0x10
    mov bx, 0x7E00
    mov ah, 0x02
    mov ch, 0x00
    mov dh, 0x00
    mov al, 0x04
    mov cl, 0x02
    mov dl, 0x80
    int 0x13
    jmp 0x0000:0x7E00

bootmsg db "GUIyetCLI Bootloader Version 0.0.1.", 0x0D, 0x0A, "Loading GUIyetCLI Operating System...", 0

times 510 - ($ - $$) db 0
dw 0xAA55