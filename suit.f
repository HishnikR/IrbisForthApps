"hsv.f" L

float x0
float x_min
float x_max
float x_step
float x_argmax
int nx

float phi0
float phi_min
float phi_max
float phi_step
float phi_argmax
int nphi


float sigma
float sigma_min
float sigma_max
float sigma_step
int nsigma

float p_max

100 CONSTANT XSIZE
100 CONSTANT YSIZE

CREATE Z[] XSIZE YSIZE * CELLS ALLOT

FLOAT ZMIN 0.0 ZMIN F!
FLOAT ZMAX 1.0 ZMAX F!

PROC Z->COLOR // F: Z -- COLOR
  ZMAX F@ F/ 767.0 F* F>S
  DUP 256 < IF
    // nothing
    ELSE DUP 255 > OVER 512 < AND IF
      256 - 256 * 255 OR
    ELSE
      512 - 65536 * 65535 OR
    THEN
  THEN

ENDPROC

0 image.show
0 0 xsize ysize 0 image.rect

int active-image

PROC ZSHOW
  active-image IMAGE.HIDE
  Z[] f@ ZMAX f!
  ysize 0 do
    xsize 0 do
      Z[] j xsize * i + -TH F@ ZMAX F@ F> if
        Z[] j xsize * i + -TH F@ ZMAX F!
      then
    loop
  loop

  ysize 0 do
    xsize 0 do
      i j
      Z[] j xsize * i + -TH F@ z->COLOR
      active-image image.pixel
    loop
  loop
 active-image IMAGE.SHOW
 0 0 xsize ysize active-image image.rect
ENDPROC

PROC TESTFILL
  ysize 0 do
    xsize 0 do
      i j + S>F 2000.0 F/
      Z[] j xsize * i + -TH F!
    loop
  loop
ENDPROC


: calc-steps
  x_max f@ x_min f@ f- nx s>f f/ x_step f!
  phi_max f@ phi_min f@ f- nphi s>f f/ phi_step f!
  sigma_max f@ sigma_min f@ f- nsigma s>f f/ sigma_step f!
;

0.1 sigma f!
0.0 x0 f!
-200.0 x_min f!
200.0 x_max f!
xsize to nx

0.0 phi0 f!
-90.0 phi_min f!
90.0 phi_max f!
ysize to nphi


0.5 sigma_min f!
5.0 sigma_max f!
10 to nsigma

calc-steps

int datasize
0 to datasize

create x[] 10000 floats allot
create y[] 10000 floats allot

: fxy // f: x, y --
  y[] datasize -th f!
  x[] datasize -th f!
  datasize 1 + to datasize
;

1.0 1.0 fxy
2.0 2.0 fxy
3.0 3.0 fxy




: gauss // f: x -- f: gauss
// use x0, sigma
  x0 f@ f- fdup f*
  sigma f@ fdup f* f/ -1.0 f* fexp
;

: p(x)
  0.0
  datasize 0 do
    x[] i -th f@ gauss f+
  loop
  sigma f@ f/
;

: index->x // index -- f: x
  s>f x_step f@ f* x_min f@ f+
;

: index->sigma // index -- f: sigma
  s>f sigma_step f@ f* sigma_min f@ f+
;




create colors[]
0 ,
0xff0000 ,
0xff8000 ,
0xffff00 ,
0xffff80 ,
0x80ffff ,
0x00ffff ,
0x0080ff ,
0x0000ff ,
0x000080 ,

: add-series
  10 0 do
    i 0 chart.addseries
    0 i series.color
    // colors[] i -th @ i series.color
    i 3 / 1 + i series.linewidth
  loop
;
add-series


: show_gauss
0 chart.show
0 chart.align.client
  10 0 do
    i series.clear
    i index->sigma sigma f!
    nx 0 do
      i index->x
      i index->x x0 f! p(x)
      j series.fxy
    loop
    i 10 * 0 progressbar.setposition
  loop
;

: f->color
  50.0 f* f>s dup 255 > if drop 255 then
  dup 0 < if drop 0 then
;

: ->radians
  180.0 f/ pi f*
;

200 constant imagex
200 constant imagey

int #image

proc scan-image
  imagey 0 do
    imagex 0 do
       i j #image image.getpixel 0 > if
         i s>f j s>f fxy
       then
    loop
  loop
endproc


: linear
// x - смещение, phi - угол
  0 image.show

  300 0 xsize ysize 0 image.rect
  // 0 0 100 100 0 image.box
  x_min f@ x0 f!
  x_max f@ x_min f@ f- nx s>f f/ x_step f!
  phi_min f@ phi0 f!
  phi_max f@ phi_min f@ f- nphi s>f f/ phi_step f!

  0.0 p_max f!

  nphi 0 do
  x_min f@ x0 f!
    nx 0 do
      0.0
      datasize 0 do
        x[] i -th f@ phi0 f@ ->radians fcos f*
        y[] i -th f@ phi0 f@ ->radians fsin f* f+
        x0 f@ f-
          fdup f*
          sigma f@ fdup f* f/ -1.0 f* fexp
        f+
      loop
      fdup p_max f@ f>
      if
        fdup p_max f!
        x0 f@ x_argmax f!
        phi0 f@ phi_argmax f!
      then
      z[] [i,j] -th f!
      x0 f@ x_step f@ f+ x0 f!
    loop
    phi0 f@ phi_step f@ f+ phi0 f!
  loop
  " Max = " print
  p_max f@ f.
  " x = " print
  x_argmax f@ f.
  " phi = " print
  phi_argmax f@ f.
;

#image IMAGE.SHOW
0 0 200 200 #image IMAGE.RECT
"cube.bmp" #image IMAGE.LOAD

0 to datasize
scan-image
"Found pixels: " print
datasize .

proc runall

  linear
  300 0 xsize ysize 0 image.rect
  zshow
endproc


proc testhsv
  9 image.show
  100 500 360 200 9 image.rect
  50 0 do
  360 0 do
    i j
    i 1.0 1.0
    HSV->RGB // h, f: s, v - rgb
    R 65536 * G 256 * + B + 9 image.pixel
  loop
  loop
endproc

