[org 0x0100]
jmp start
starting: db 'Press Any Key to START!'
ending: db 'Game Over!'
oldkb: dd 0
alpha1: dw 0
alpha2: dw 0
alpha3: dw 0
alpha4: dw 0
alpha5: dw 0
loc1: dw 0
loc2: dw 0
loc3: dw 0
loc4: dw 0
loc5: dw 0
locBox: dw 3918
rand: dw 0
randnum: dw 0
score: dw 0
missed: dw 0
printnum:     push bp 
              mov  bp, sp 
              push es 
              push ax 
              push bx 
              push cx 
              push dx 
              push di 
              mov  ax, 0xb800 
              mov  es, ax             ; point es to video base 
              mov  ax, [bp+4]         ; load number in ax 
              mov  bx, 10             ; use base 10 for division 
              mov  cx, 0              ; initialize count of digits 
nextdigit:    mov  dx, 0              ; zero upper half of dividend 
              div  bx                 ; divide by 10 
              add  dl, 0x30           ; convert digit into ascii value 
              push dx                 ; save ascii value on stack 
              inc  cx                 ; increment count of values  
              cmp  ax, 0              ; is the quotient zero 
              jnz  nextdigit          ; if no divide it again 
              mov  di, [bp+6]              ; point di to top left column 
nextpos:      pop  dx                 ; remove a digit from the stack 
              mov  dh, 0x07           ; use normal attribute 
              mov [es:di], dx         ; print char on screen 
              add  di, 2              ; move to next screen location 
              loop nextpos            ; repeat for all digits on stack
 
              pop  di 
              pop  dx 
              pop  cx 
              pop  bx 
              pop  ax 
              pop  es 
              pop  bp 
              ret  4 
			  
scoreDetails:
push ax
push bx
push cx
push dx
push si
push di

mov ax,0xb800
mov es,ax
mov word [es:130],0x0e53;S
mov word [es:132],0x0e63;c
mov word [es:134],0x0e6f;o
mov word [es:136],0x0e72;r
mov word [es:138],0x0e65;e
mov word [es:140],0x0e3A;:
mov ax,142
push ax
push word [score]
call printnum 

mov word [es:16],0x0e4D;M
mov word [es:18],0x0e69;i
mov word [es:20],0x0e73;s
mov word [es:22],0x0e73;s
mov word [es:24],0x0e65;e
mov word [es:26],0x0e64;d
mov word [es:28],0x0e3A;:

mov ax,30
push ax
push word [missed]
call printnum 
mov di,[locBox]
mov word [es:di],0x0EDC

cmp word [missed],10
je terminate
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

delay:
push ax
push bx
push cx
push dx
push si
push di
mov cx,0xffff
delaying:
loop delaying
mov cx,0xffff
delaying2:
loop delaying2
mov cx,0xffff
delaying3:
loop delaying3
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
; taking n as parameter, generate random number from 0 to n nad return in the stack
randG:
   push bp
   mov bp, sp
   pusha
   cmp word [rand], 0
   jne next

  MOV     AH, 00h   ; interrupt to get system timer in CX:DX 
  INT     1AH
  inc word [rand]
  mov     [randnum], dx
  jmp next1

  next:
  mov     ax, 25173          ; LCG Multiplier
  mul     word  [randnum]     ; DX:AX = LCG multiplier * seed
  add     ax, 13849          ; Add LCG increment value
  ; Modulo 65536, AX = (multiplier*seed+increment) mod 65536
  mov     [randnum], ax          ; Update seed = return value

 next1:xor dx, dx
 mov ax, [randnum]
 mov cx, [bp+4]
 inc cx
 div cx
 
 mov [bp+6], dx
 popa
 pop bp
 ret 2
clearScreen:
push ax
push bx
push cx
push dx
push si
push di
mov cx,2000
mov di,0
clearing:
mov word[es:di],0x0720
add di,2
loop clearing
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

generateRandom1:
push ax
push bx
push cx
push dx
push si
push di

sub sp, 2
push 79
call randG
pop ax
mov bl,25
div bl
add ah,65
mov dl,AH
mov dh,0xA
mov [alpha1],dx
mov dx,[alpha1]

sub sp, 2
push 79
call randG
pop ax
mov bl,80
div bl
shl ah,1
mov dl,AH
mov dh,0
mov [loc1],dx

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
generateRandom2:
push ax
push bx
push cx
push dx
push si
push di

sub sp, 2
push 79
call randG
pop ax
mov bl,25
div bl
add ah,65
mov dl,AH
mov dh,0x9
mov [alpha2],dx
mov dx,[alpha2]

sub sp, 2
push 79
call randG
pop ax
mov bl,80
div bl
shl ah,1
mov dl,AH
mov dh,0
mov [loc2],dx

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
generateRandom3:
push ax
push bx
push cx
push dx
push si
push di

sub sp, 2
push 79
call randG
pop ax
mov bl,25
div bl
add ah,65
mov dl,AH
mov dh,0xC
mov [alpha3],dx
mov dx,[alpha3]

sub sp, 2
push 79
call randG
pop ax
mov bl,80
div bl
shl ah,1
mov dl,AH
mov dh,0
mov [loc3],dx

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
generateRandom4:
push ax
push bx
push cx
push dx
push si
push di

sub sp, 2
push 79
call randG
pop ax
mov bl,25
div bl
add ah,65
mov dl,AH
mov dh,0xD
mov [alpha4],dx
mov dx,[alpha4]

sub sp, 2
push 79
call randG
pop ax
mov bl,80
div bl
shl ah,1
mov dl,AH
mov dh,0
mov [loc4],dx

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
generateRandom5:
push ax
push bx
push cx
push dx
push si
push di

sub sp, 2
push 79
call randG
pop ax
mov bl,25
div bl
add ah,65
mov dl,AH
mov dh,0xB
mov [alpha5],dx
mov dx,[alpha5]

sub sp, 2
push 79
call randG
pop ax
mov bl,80
div bl
shl ah,1
mov dl,AH
mov dh,0
mov [loc5],dx

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

movingAlpha1:
push ax
push bx
push cx
push dx
push si
push di
mov ax,3840
cmp [loc1],ax
jge baseCondition1
jmp ignore1
baseCondition1:
mov di,[loc1]
cmp word [es:di],0x0EDC
jne noScore1
add word [score],1
jmp score1
noScore1:
add word [missed],1
score1:
mov word [es:di],0x0720
call generateRandom1
ignore1:
call delay
mov di,[loc1]
mov word [es:di],0x0720
add di,160
mov [loc1],di
mov ax,[alpha1]
mov [es:di],ax
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
movingAlpha2:
push ax
push bx
push cx
push dx
push si
push di
mov ax,3840
cmp [loc2],ax
jge baseCondition2
jmp ignore2
baseCondition2:
mov di,[loc2]
cmp word [es:di],0x0EDC
jne noScore2
add word [score],1
jmp score2
noScore2:
add word [missed],1
score2:
mov word [es:di],0x0720
call generateRandom2
ignore2:
call delay
mov di,[loc2]
mov word [es:di],0x0720
add di,160
mov [loc2],di
mov ax,[alpha2]
mov [es:di],ax
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
movingAlpha3:
push ax
push bx
push cx
push dx
push si
push di
mov ax,3840
cmp [loc3],ax
jge baseCondition3
jmp ignore3
baseCondition3:
mov di,[loc3]
cmp word [es:di],0x0EDC
jne noScore3
add word [score],1
jmp score3
noScore3:
add word [missed],1
score3:
mov word [es:di],0x0720
call generateRandom3
ignore3:
call delay
mov di,[loc3]
mov word [es:di],0x0720
add di,160
mov [loc3],di
mov ax,[alpha3]
mov [es:di],ax
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
movingAlpha4:
push ax
push bx
push cx
push dx
push si
push di
mov ax,3840
cmp [loc4],ax
jge baseCondition4
jmp ignore4
baseCondition4:
mov di,[loc4]
cmp word [es:di],0x0EDC
jne noScore4
add word [score],1
jmp score4
noScore4:
add word [missed],1
score4:
mov word [es:di],0x0720
call generateRandom4
ignore4:
call delay
mov di,[loc4]
mov word [es:di],0x0720
add di,160
mov [loc4],di
mov ax,[alpha4]
mov [es:di],ax
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
movingAlpha5:
push ax
push bx
push cx
push dx
push si
push di
mov ax,3840
cmp [loc5],ax
jge baseCondition5
jmp ignore5
baseCondition5:
mov di,[loc5]
cmp word [es:di],0x0EDC
jne noScore5
add word [score],1
jmp score5
noScore5:
add word [missed],1
score5:
mov word [es:di],0x0720
call generateRandom5
ignore5:
call delay
mov di,[loc5]
mov word [es:di],0x0720
add di,160
mov [loc5],di
mov ax,[alpha5]
mov [es:di],ax
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
movingDown:
push ax
push bx
push cx
push dx
push si
push di

call movingAlpha4
call scoreDetails
call movingAlpha5
call scoreDetails
call movingAlpha1
call scoreDetails
call movingAlpha2
call scoreDetails
call movingAlpha3
call scoreDetails
call movingAlpha4
call scoreDetails
call movingAlpha3
call scoreDetails
call movingAlpha5
call scoreDetails
call movingAlpha2
call scoreDetails
call movingAlpha4
call scoreDetails
call movingAlpha5
call scoreDetails
call movingAlpha5
call scoreDetails
call movingAlpha3
call scoreDetails
call movingAlpha4
call scoreDetails
call movingAlpha5
call scoreDetails
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
moveleft:
push ax
push bx
push cx
push dx
push si
push di
mov di,[locBox]
mov word [es:di],0x0720
sub di,2
cmp di,3838
je reset2
jmp ignore7
reset2: mov di,3998
ignore7:
mov [locBox],di
mov word [es:di],0x0EDC
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
moveright:
push ax
push bx
push cx
push dx
push si
push di
mov di,[locBox]
mov word [es:di],0x0720
add di,2
cmp di,4000
je reset1
jmp ignore6
reset1: mov di,3840
ignore6:
mov [locBox],di
mov word [es:di],0x0EDC
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
hook09h:
push ax
in al, 0x60
cmp al, 0x4b
jne nextcmp
call moveleft
jmp exit
nextcmp:
cmp al, 0x4d
jne nomatch
call moveright
jmp exit
nomatch:
pop ax
jmp far [cs:oldkb]
kbreturn:
exit: 
mov al, 0x20
out 0x20, al
pop ax
iret

start:
mov ax,0xb800
mov es,ax
call clearScreen
call scoreDetails
mov cx,23
mov si,starting
mov ah,0x8c
mov di,1816
nextchar1:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop nextchar1
mov ah, 0
int 16h
xor ax,ax
mov es, ax
mov ax, [es:9*4]
mov word[oldkb], ax
mov ax, [es:9*4+2]
mov word[oldkb+2], ax
mov word [es:9h*4],hook09h
mov [es:9h*4+2], cs
mov ax,0xb800
mov es,ax
call clearScreen
call scoreDetails
mov word [es:3918],0x0eDC
call generateRandom1
call generateRandom2
call generateRandom3
call generateRandom4
call generateRandom5
infinite:
call movingDown
jmp infinite
terminate:
call clearScreen
mov word [es:130],0x0e53;S
mov word [es:132],0x0e63;c
mov word [es:134],0x0e6f;o
mov word [es:136],0x0e72;r
mov word [es:138],0x0e65;e
mov word [es:140],0x0e3A;:
mov ax,142
push ax
push word [score]
call printnum 

mov word [es:16],0x0e4D;M
mov word [es:18],0x0e69;i
mov word [es:20],0x0e73;s
mov word [es:22],0x0e73;s
mov word [es:24],0x0e65;e
mov word [es:26],0x0e64;d
mov word [es:28],0x0e3A;:

mov ax,30
push ax
push word [missed]
call printnum 
mov cx,10
mov si,ending
mov ah,0x8c
mov di,1830
nextchar2:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop nextchar2
mov ax,0x4c00
int 21h
