bits 64
global _start

section .data
  dfizz: DB "fizz"
  dfizz_len: equ $-dfizz
  dbuzz: DB "buzz"
  dbuzz_len: equ $-dbuzz
  dneg: DB "-"
  dneg_len: equ $-dneg
  linefeed: DB 10

section .text
write:
  mov rax,0x01
  mov rdi,0x01
  syscall
  ret

fizz:
  mov r11,0x01
  mov rsi,dfizz
  mov rdx,dfizz_len
  call write
  jmp process2

buzz:
  mov r11,0x01
  mov rsi,dbuzz
  mov rdx,dbuzz_len
  call write
  jmp almostdone

negative:
  mov rsi,dneg
  mov rdx,dneg_len
  call write
  jmp almostdone

newline:
  mov rsi,linefeed
  mov rdx,0x01
  call write
  ret

process1:
  mov rax,r8
  mov r9,0x03
  mov rdx,0
  div r9 ;store the remainder in rdx
  cmp rdx,0x00
  je fizz

process2:
  mov rax,r8
  mov r9,0x05
  mov rdx,0
  div r9 ;store the remainder in rdx
  cmp rdx,0x00
  je buzz

process3:
  cmp r11,0x00
  je negative
  jmp almostdone

exit:
  mov rax,0x3c
  mov rdi,0x01
  syscall

_start:
  mov r8,0x01

loop:
  mov r11,0x00
  jmp process1
  
almostdone:
  call newline
  inc r8
  cmp r8,100
  jge exit
  jmp loop
