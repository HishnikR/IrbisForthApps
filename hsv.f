
int R
int G
int B

int H
float S
float V
float Vmin
float Vinc
float Vdec

int Hi

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

proc %byte
  255.0 f* 100.0 f/ f>s
endproc

proc HSV->RGB // H, f: S, V --
  100.0 f* V f!
  100.0 f* S f!
  to H

  H 60 / 6 mod to Hi
  100.0 S f@ f- V f@ f* 100.0 f/ Vmin f!

  // a
  V f@ Vmin f@ f-
  H 60 mod s>f f* 60.0 f/

  fdup Vmin f@ f+ Vinc f!
  V f@ fswap f- Vdec f!

  Hi 0 = if
    V f@ %byte to R
    Vinc f@ %byte to G
    Vmin f@ %byte to B
  then

  Hi 1 = if
    Vdec f@ %byte to R
    V f@ %byte to G
    Vmin f@ %byte to B
  then

  Hi 2 = if
    Vmin f@ %byte to R
    V f@ %byte to G
    Vinc f@ %byte to B
  then

  Hi 3 = if
    Vmin f@ %byte to R
    Vdec f@ %byte to G
    V f@ %byte to B
  then

  Hi 4 = if
    Vinc f@ %byte to R
    Vmin f@ %byte to G
    V f@ %byte to B
  then

  Hi 5 = if
    V f@ %byte to R
    Vmin f@ %byte to G
    Vdec f@ %byte to B
  then
endproc


"red" print
255 0 0 RGB->HSV H .
"green" print
0 255 0 RGB->HSV H .
"blue" print
0 0 255 RGB->HSV H .

"hsv->rgb" print
10 0.7 0.8 HSV->RGB
R . G . B .

