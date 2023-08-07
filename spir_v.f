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

int matrix1
int matrix2
int matrix3

create str 512 allot

proc printm4fp32 // matrix --

  " " str s!
  4 0 do
    str over i -th sf@ %f
  loop
  str print

    " " str s!
  8 4 do
    str over i -th sf@ %f
  loop
  str print

  " " str s!
  12 8 do
    str over i -th sf@ %f
  loop
  str print

  " " str s!
  16 12 do
    str over i -th sf@ %f
  loop
  str print

  drop
endproc

proc @fp32 // matrix, index -- f: value
   -th sf@
endproc

proc !fp32 // matrix, index, f: value --
   -th sf!
endproc

proc m*+fp32 // index_m1, index_m2 --
  matrix2 swap @fp32
  matrix1 swap @fp32 f* f+
endproc

proc M4*4FP32 // addr1, addr2, addr_res --
  to matrix3
  to matrix2
  to matrix1

  0.0
  0 0 m*+fp32 1 4 m*+fp32 2 8 m*+fp32 3 12 m*+fp32 matrix3 0 !fp32

  0.0
  0 1 m*+fp32 1 5 m*+fp32 2 9 m*+fp32 3 13 m*+fp32 matrix3 1 !fp32

  0.0
  0 2 m*+fp32 1 6 m*+fp32 2 10 m*+fp32 3 14 m*+fp32 matrix3 2 !fp32

  0.0
  0 3 m*+fp32 1 7 m*+fp32 2 11 m*+fp32 3 15 m*+fp32 matrix3 3 !fp32


endproc

