
int a1
int a2
int b1
int b2
int c1
int c2
int carry

proc d+
  to b1
  to b2
  to a1
  to a2

  a1 0xffffffff and b1 0xffffffff and + dup 0xffffffff and to c1
  0x100000000 and if 1 to carry else 0 to carry then

  a1 32 rshift 0xffffffff and b1 32 rshift 0xffffffff and + carry + dup
  32 lshift c1 or to c1
  0x100000000 and if 1 to carry else 0 to carry then

  a2 0xffffffff and b2 0xffffffff and + carry + dup 0xffffffff and to c2
  0x100000000 and if 1 to carry else 0 to carry then

  a2 32 rshift 0xffffffff and b2 32 rshift 0xffffffff and + carry +
  32 lshift c2 or to c2

  c2 c1
endproc

0 0xffffffffffffffff 0 1 d+ "lo" print . "hi" print .

0 0xffffffffffffffff 0 2 d+ "lo" print . "hi" print .


