
0 CHART.SHOW
0 CHART.ALIGN.CLIENT

0 0 CHART.ADDSERIES
1 0 CHART.ADDSERIES
2 0 CHART.ADDSERIES
3 0 CHART.ADDSERIES
4 0 CHART.ADDSERIES
5 0 CHART.ADDSERIES
6 0 CHART.ADDSERIES

0xFF00FF 0 SERIES.COLOR
0xDFDF40 1 SERIES.COLOR

0x0000ff 3 series.color
0x00ff00 4 series.color

0x00007f 5 series.color
0x007f00 6 series.color



3 0 SERIES.LINEWIDTH
3 1 SERIES.LINEWIDTH
3 2 SERIES.LINEWIDTH
5 3 SERIES.LINEWIDTH
5 4 SERIES.LINEWIDTH
7 5 SERIES.LINEWIDTH
7 6 SERIES.LINEWIDTH

variable wavre
variable wavim
variable signal
variable sumre
variable sumim

variable phase

: DRAW
  0 SERIES.CLEAR
  1 SERIES.CLEAR
  2 SERIES.CLEAR
  3 SERIES.CLEAR
  4 SERIES.CLEAR
  5 SERIES.CLEAR
  6 SERIES.CLEAR

  0.0 sumre f!
  0.0 sumim f!

  1000 0 DO
    I 500 - S>F
    FDUP 50.0 F/ FSIN
    I 500 - S>F 250.0 F/ FDUP F* FEXP F/  fdup wavim f!
    0 SERIES.FXY

    I 500 - S>F
    FDUP 50.0 F/ FCOS
    I 500 - S>F 250.0 F/ FDUP F* FEXP F/ fdup wavre f!
    1 SERIES.FXY

    I 500 - S>F
    FDUP 50.0 F/ phase f@ f- FCOS fdup signal f!
    2 SERIES.FXY

    I 500 - S>F
    wavre f@ signal f@ f*
    fdup sumre f@ f+ sumre f!
    3 SERIES.FXY

    I 500 - S>F
    wavim f@ signal f@ f*
    fdup sumim f@ f+ sumim f!
    4 SERIES.FXY

    I 500 - S>F
    sumre f@ 200.0 f/
    5 SERIES.FXY

    I 500 - S>F
    sumim f@ 200.0 f/
    6 SERIES.FXY


  LOOP

;

10 0 chart.axis.xticks
10 1 chart.axis.xticks

DRAW



: DRAW-RE
  0 SERIES.CLEAR
  1 SERIES.CLEAR

  1000 0 DO
    I 500 - S>F
    FDUP 50.0 F/ FSIN
    I 500 - S>F 250.0 F/ FDUP F* FEXP F/
    0 SERIES.FXY
  LOOP
;

: DRAW-IM
  0 SERIES.CLEAR
  1 SERIES.CLEAR

  1000 0 DO
    I 500 - S>F
    FDUP 50.0 F/ FCOS
    I 500 - S>F 250.0 F/ FDUP F* FEXP F/
    1 SERIES.FXY
  LOOP
;

PROC DRAW-PHASE
  0 TRACKBAR.GETPOSITION s>f 255.0 f/ pi f* 2.0 f/
  phase f!
  draw
ENDPROC

  0 TRACKBAR.GETPOSITION

0 TRACKBAR.SHOW
0 0 500 50 0 TRACKBAR.RECT
0 0 TRACKBAR.MIN
255 0 TRACKBAR.MAX
25 0 TRACKBAR.STEP
"DRAW-PHASE" 0 TRACKBAR.ACTION








