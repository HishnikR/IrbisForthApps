
: P0 0.0 0.0 0.0 ;
: PX1 0.8 0.0 0.0 ;
: PY1 0.0 0.8 0.0 ;
: PZ1 0.0 0.0 0.8 ;

: P1 -0.5 -0.5 -0.5 ;
: P2 -0.5 0.5 -0.5 ;
: P3 0.5 0.5 -0.5 ;
: P4 0.5 -0.5 -0.5 ;
: P5 -0.5 -0.5 0.5 ;
: P6 -0.5 0.5 0.5 ;
: P7 0.5 0.5 0.5 ;
: P8 0.5 -0.5 0.5 ;

VARIABLE RX
VARIABLE RY
VARIABLE RZ
170.0 RX F!
170.0 RY F!
50.0 RZ F!


100 CONSTANT XSIZE
100 CONSTANT YSIZE

CREATE Z[] XSIZE YSIZE * FLOATS ALLOT

FLOAT SIGMA 0.2 SIGMA F!

: FILL-Z[]
  YSIZE 0 DO
    XSIZE 0 DO
      I S>F XSIZE S>F F/ 0.5 F- FDUP F*
      J S>F YSIZE S>F F/ 0.5 F- FDUP F* F+
      SIGMA F@ FDUP F* F/ -1.0 F* FEXP
      Z[] J XSIZE * I + -TH F!
    LOOP
  LOOP
;

proc fill-circle
  YSIZE 0 DO
    XSIZE 0 DO
      I S>F XSIZE S>F F/ 0.5 F- FDUP F*
      J S>F YSIZE S>F F/ 0.5 F- FDUP F* F+ FSQRT
      0.2 F- fabs
      0.3 FDUP F* F/ -1.0 F* FEXP
      Z[] J XSIZE * I + -TH F!
    LOOP
  LOOP
endproc


FILL-Z[]
fill-circle

int vi
int vj

: XY-LINE // x, y --
   to vj
   to vi
   VI S>F XSIZE S>F F/ 0.5 F-
   VJ S>F YSIZE S>F F/ 0.5 F-
   0.0
   OPENGL.VERTEX3D

   VI S>F XSIZE S>F F/ 0.5 F-
   VJ S>F YSIZE S>F F/ 0.5 F-
   Z[] VJ XSIZE * VI + -TH F@
   OPENGL.VERTEX3D
;

: vert-lines
  OPENGL.LINE
  1.0 0.0 1.0 OPENGL.COLOR3F
  20 30 xy-line
  OPENGL.END

  OPENGL.LINE
  1.0 0.0 1.0 OPENGL.COLOR3F
  30 60 xy-line
  OPENGL.END

  OPENGL.LINE
  1.0 0.0 1.0 OPENGL.COLOR3F
  60 40 xy-line
  OPENGL.END
;

: RUNOPENGL3D

  OPENGL.MATRIX.MODELVIEW
  -1.0 1.0 -1.0 1.0 -1.0 1.0 OPENGL.ORTHO
  OPENGL.LOADIDENTITY

  OPENGL.CLEAR

  OPENGL.FRONT.CW

  OPENGL.PUSHMATRIX

  RX F@ 0.0 0.0 1.0 OPENGL.ROTATEF
  RY F@ 0.0 1.0 0.0 OPENGL.ROTATEF
  RZ F@ 1.0 0.0 0.0 OPENGL.ROTATEF

  OPENGL.LINE
  1.0 0.0 0.0 OPENGL.COLOR3F
  P0 OPENGL.VERTEX3D
  PX1 OPENGL.VERTEX3D
  OPENGL.END

  OPENGL.LINE
  0.0 1.0 0.0 OPENGL.COLOR3F
  P0 OPENGL.VERTEX3D
  PY1 OPENGL.VERTEX3D
  OPENGL.END

  OPENGL.LINE
  0.0 0.0 1.0 OPENGL.COLOR3F
  P0 OPENGL.VERTEX3D
  PZ1 OPENGL.VERTEX3D
  OPENGL.END

  YSIZE 1 - 0 DO
    XSIZE 1 - 0 DO
      OPENGL.LINE
      1.0 1.0 0.0 OPENGL.COLOR3F
      I S>F XSIZE S>F F/ 0.5 F-
      J S>F YSIZE S>F F/ 0.5 F-
      Z[] J XSIZE * I + -TH F@
      OPENGL.VERTEX3D
      I 1 + S>F XSIZE S>F F/ 0.5 F-
      J S>F YSIZE S>F F/ 0.5 F-
      Z[] J XSIZE * I + 1 + -TH F@
      OPENGL.VERTEX3D
      OPENGL.END

      OPENGL.LINE
      1.0 1.0 0.0 OPENGL.COLOR3F
      I S>F XSIZE S>F F/ 0.5 F-
      J S>F YSIZE S>F F/ 0.5 F-
      Z[] J XSIZE * I + -TH F@
      OPENGL.VERTEX3D
      I S>F XSIZE S>F F/ 0.5 F-
      J 1 + S>F YSIZE S>F F/ 0.5 F-
      Z[] J 1 + XSIZE * I + -TH F@
      OPENGL.VERTEX3D
      OPENGL.END
    LOOP
  LOOP

// vert-lines

  OPENGL.POPMATRIX

;

: X- RX F@ 15.0 F- RX F! OPENGL3D OPENGL.UPDATE ;
: X+ RX F@ 15.0 F+ RX F! OPENGL3D OPENGL.UPDATE ;
: Y- RY F@ 15.0 F- RY F! OPENGL3D OPENGL.UPDATE ;
: Y+ RY F@ 15.0 F+ RY F! OPENGL3D OPENGL.UPDATE ;
: Z- RZ F@ 15.0 F- RZ F! OPENGL3D OPENGL.UPDATE ;
: Z+ RZ F@ 15.0 F+ RZ F! OPENGL3D OPENGL.UPDATE ;

OPENGL.SHOW
100 50 1000 800 OPENGL.RECT
USE RUNOPENGL3D TO OPENGL3D

0 BUTTON.SHOW
0 0 100 40 0 BUTTON.RECT
" X-" 0 BUTTON.TEXT
" X-" 0 BUTTON.ACTION

1 BUTTON.SHOW
0 50 100 40 1 BUTTON.RECT
" X+" 1 BUTTON.TEXT
" X+" 1 BUTTON.ACTION

2 BUTTON.SHOW
0 100 100 40 2 BUTTON.RECT
" Y-" 2 BUTTON.TEXT
" Y-" 2 BUTTON.ACTION

3 BUTTON.SHOW
0 150 100 40 3 BUTTON.RECT
" Y+" 3 BUTTON.TEXT
" Y+" 3 BUTTON.ACTION


4 BUTTON.SHOW
0 200 100 40 4 BUTTON.RECT
" Z-" 4 BUTTON.TEXT
" Z-" 4 BUTTON.ACTION

5 BUTTON.SHOW
0 250 100 40 5 BUTTON.RECT
" Z+" 5 BUTTON.TEXT
" Z+" 5 BUTTON.ACTION



