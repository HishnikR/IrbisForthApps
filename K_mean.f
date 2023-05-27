
500 CONSTANT XSIZE
500 CONSTANT YSIZE

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

: images
  4 0 do
    i IMAGE.SHOW
    100 i ysize 50 + * 100 + XSIZE YSIZE i IMAGE.RECT
  loop
;

images

0 PROGRESSBAR.SHOW
0 0 PROGRESSBAR.MIN
100 0 PROGRESSBAR.MAX

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
ENDPROC

PROC TESTFILL
  ysize 0 do
    xsize 0 do
      i j + S>F 2000.0 F/
      Z[] j xsize * i + -TH F!
    loop
  loop
ENDPROC

INT NDATA

CREATE DATAX[] 100 cells allot
//               100.0 F, 140.0 F, 180.0 F,
//               200.0 F, 240.0 F, 280.0 F,
//               300.0 F, 340.0 F, 380.0 F,

CREATE DATAY[] 100 cells allot
// 100.0 F,  80.0 F, 120.0 F,
//               600.0 F, 580.0 F, 620.0 F,
//               300.0 F, 280.0 F, 320.0 F,

// 9 TO NDATA


: xy // f: x, y --
  DATAY[] NDATA -TH F!
  DATAX[] NDATA -TH F!
  NDATA 1 + TO NDATA
;

43.892857 46.392857 xy

43.892857 64.25 xy

43.892857 83.535713 xy

158.07144 43.785713 xy

158.07144 62.35714 xy

158.07143 78.785713 xy

73.785713 118.07142 xy

73.071434 136.64287 xy

90.214287 150.21429 xy

110.21429 150.92857 xy

128.07143 116.64285 xy

128.78572 135.92857 xy

int nxy

create XY[] 200000 floats allot
"un.csv" 0 FILE.TEXT.OPEN drop
0 XY[] FILE.TEXT.FXY to nxy
0 file.text.close drop

proc xyshow
  0 image.hide
  100 100 500 500 0 image.rect
  1000 0 do
    1000 0 do
      i j 0 0 image.pixel
    loop
  loop

  nxy 0 do
    xy[] i 2 * -th f@ f>s
    xy[] i 2 * 1 + -th f@ f>s
    0x00ffff 0 image.pixel
  loop
  0 image.show
endproc

FLOAT SIGMA 10.0 SIGMA F!
INT INDEX
FLOAT Y
FLOAT X

PROC GAUSS2D // INDEX, F: X, Y --> F: P
  TO INDEX
  Y F!
  X F!

  1.0
  DATAX[] INDEX -TH F@ X F@ F- FDUP F*
  DATAY[] INDEX -TH F@ Y F@ F- FDUP F* F+
  SIGMA F@ FDUP F* F/ FEXP
  F/
ENDPROC



proc xygauss
  YSIZE 0 do
    XSIZE 0 do
      xy[] nxy i s>f j s>f sigma f@ fgauss[]2d
      z[] j XSIZE * i + -th f!
    loop
  loop
endproc

PROC FILLSIGMA
     ysize 0 do
      xsize 0 do
        0.0 Z[] j xsize * i + -TH F!
      loop
    loop

  0 PROGRESSBAR.SHOW
  100 50 XSIZE 30 0 PROGRESSBAR.RECT
  0 0 PROGRESSBAR.MIN
  YSIZE 10 / 0 PROGRESSBAR.MAX

   1.0 ZMAX F!
   NDATA 0 DO
     ysize 0 do
      xsize 0 do
        i s>f j s>f k Gauss2d
        Z[] j xsize * i + -TH F@ F+
        FDUP ZMAX F@ F> IF FDUP ZMAX F! THEN
        Z[] j xsize * i + -TH F!
      loop
      I 10 / NDATA / 0 PROGRESSBAR.SETPOSITION $
    loop
   LOOP
ENDPROC

INT ADDR
FLOAT Fc
INT NMAX

PROC COUNTMAX
  0 TO NMAX
     ysize 1 - 1 do
      xsize 1 - 1 do
       Z[] j xsize * i + -TH DUP TO ADDR F@ Fc F!
       Fc F@ ADDR 8 - F@ F>
       Fc F@ ADDR 8 + F@ F> AND
       Fc F@ ADDR XSIZE 8 * - F@ F> AND
       Fc F@ ADDR XSIZE 8 * + F@ F> AND
       Fc F@ ADDR XSIZE 8 * - 8 - F@ F> AND
       Fc F@ ADDR XSIZE 8 * + 8 - F@ F> AND
       Fc F@ ADDR XSIZE 8 * - 8 + F@ F> AND
       Fc F@ ADDR XSIZE 8 * + 8 + F@ F> AND
       IF
          NMAX 1 + TO NMAX
       THEN
      loop
    loop

ENDPROC

0 label.show
400 10 200 50 0 label.rect
0 0 label.int

0 BUTTON.SHOW
10 10 200 50 0 BUTTON.RECT
" Run" 0 BUTTON.TEXT
" FILLSIGMA COUNTMAX NMAX 0 LABEL.INT ZSHOW" 0 BUTTON.ACTION

float s0 1.0 s0 F!
float sstep 1.0 sstep F!



proc explore
  0 chart.show
  0 0 CHART.ADDSERIES
    0 SERIES.CLEAR
  3 0 SERIES.LINEWIDTH
  600 XSIZE + 100 1000 1000 0 chart.RECT
  0.0 0.0 0 series.fxy

  50 0 do
    i s>f sstep f@ f* s0 F@ f+ sigma f!
    FILLSIGMA
    sigma f@
    COUNTMAX NMAX s>f
    0 SERIES.FXY
  loop

endproc

create sigma[] 5.0 f, 15.0 f, 30.0 f, 50.0 f,

proc runall
  4 0 do
    sigma[] i -th f@ sigma f!
    fillsigma
    i to active-image
    zshow
  loop
endproc


proc explorexy

  10.0 s0 F!
  2.0 sstep F!

  0 chart.show
  0 0 CHART.ADDSERIES
    0 SERIES.CLEAR
  3 0 SERIES.LINEWIDTH
  600 XSIZE + 100 1000 1000 0 chart.RECT
  0.0 0.0 0 series.fxy

  25 0 do
    i s>f sstep f@ f* s0 F@ f+ sigma f!
    xygauss
    sigma f@
    COUNTMAX NMAX s>f
    0 SERIES.FXY
  loop

endproc

