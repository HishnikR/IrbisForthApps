32 CONSTANT #REGS
1024 CONSTANT #PROGRAMSIZE

CREATE REG[] #REGS CELLS ALLOT

CREATE PROGRAM[] #PROGRAMSIZE CELLS ALLOT

int pc
int code^
int cmd

proc step
  PROGRAM[] pc -th @ to cmd
  pc 1 + to pc

endproc

proc HL_M4*4 // index1, index2 --

endproc

