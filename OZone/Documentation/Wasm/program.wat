wasm-function[0]:
  sub rsp, 8                            ; 0x000000 48 83 ec 08
  mov eax, dword ptr [r15 + 4]          ; 0x000004 41 8b 47 04
  sub eax, 0x10                         ; 0x000008 83 e8 10
  mov dword ptr [r15 + rax + 0xc], 0    ; 0x00000b 41 c7 44 07 0c 00 00 00 00
  xor eax, eax                          ; 0x000014 33 c0
  nop                                   ; 0x000016 66 90
  add rsp, 8                            ; 0x000018 48 83 c4 08
  ret                                   ; 0x00001c c3

