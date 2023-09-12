
int R
int G
int B

int H
float S
float V

proc MAX3 // a, b, c -- max
   over over > if drop else swap drop then
   over over > if drop else swap drop then
endproc

proc MIN3 // a, b, c -- min
   over over < if drop else swap drop then
   over over < if drop else swap drop then
endproc

proc RGB->HSV // R, G, B --
  to B to G to R
  R B > R G > and if
    G B - 60 *
    R G B MAX3 R G B MIN3 - dup 0 = if 1 + then
    /
    G B < if
      360 +
    then
  else
    G B > if
       B R - 60 *
       R G B MAX3 R G B MIN3 - dup 0 = if 1 + then
       / 120 +
    else
      R G -
       R G B MAX3 R G B MIN3 - dup 0 = if 1 + then
       / 240 +
    then
  then
  to H
endproc

255 0 0 RGB->HSV H .
0 255 0 RGB->HSV H .
0 0 255 RGB->HSV H .
