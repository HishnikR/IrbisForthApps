

100 CONSTANT DATASIZE

CREATE X[] DATASIZE FLOATS ALLOT

INT WINDOW
10 TO WINDOW
INT TIME

50 TO TIME

FLOAT SIGMA
FLOAT SIGMA0
FLOAT EPSILON

1.0 SIGMA0 F!
0.1 EPSILON F!

FLOAT X0

PROC P(X) // F:X-- F: P
  X0 F!
  0.0
  WINDOW 0 DO
    X[] TIME I - -TH F@ X0 F@ F-
    I S>F EPSILON F@ F* SIGMA0 F@ F+ SIGMA F!
    SIGMA F@ FGAUSS F+
  LOOP
ENDPROC

PROC FILLCONST
  datasize 0 DO
    1.0 X[] I -TH F!
    i datasize 2 / > if
      2.0 X[] I -TH F!
    then
  LOOP
ENDPROC

FILLCONST

FLOAT XMIN
FLOAT XMAX
FLOAT XSTEP
INT STEPS

FLOAT PMAX
FLOAT ARGMAX


PROC FINDX
  XMAX F@ XMIN F@ F- STEPS S>F F/ XSTEP F!
  0.0 PMAX F!
  XMIN F@ ARGMAX F!
  XMIN F@ X0 F!
  STEPS 0 DO
    X0 F@ P(X) FDUP PMAX F@ F> IF
      FDUP PMAX F! X0 F@ ARGMAX F!
    THEN FDROP
    X0 F@ XSTEP F@ F+ X0 F!
  LOOP
ENDPROC

float y(i-1)
float sumdelta^2
float sumdydt^2

proc bayesfilt
  0.0 sumdelta^2 f!
  0.0 sumdydt^2 f!
  1 series.clear
  datasize window - window do
    i to time
    i s>f
    FINDX ARGMAX F@
    1 series.fxy
    i window > if
      argmax f@ x[] i -th f@ f- fdup f* sumdelta^2 f@ f+ sumdelta^2 f!
      argmax f@ y(i-1) f@ f- fdup f* sumdydt^2 f@ f+ sumdydt^2 f!
      argmax f@ y(i-1) f!
    then
  loop
endproc

0 chart.show
0 0 2000 700 0 chart.rect
0 0 chart.addseries
1 0 chart.addseries
2 0 chart.addseries

3 0 series.linewidth
3 1 series.linewidth
3 2 series.linewidth

0x00ff00 1 series.color
0xff0000 2 series.color

proc showdata
  0 series.clear
  datasize 0 DO
    i s>f
    x[] i -th f@
    0 series.fxy
  loop
endproc

proc showaverage
  0.0 sumdelta^2 f!
  0.0 sumdydt^2 f!
  2 series.clear
  datasize window - window do
    i to time
    i window + 1 - s>f
    0.0
    i window + i do
      x[] i -th f@ f+
    loop
    window s>f f/
     fdup argmax f!
       i window > if
        argmax f@ x[] i -th f@ f- fdup f* sumdelta^2 f@ f+ sumdelta^2 f!
        argmax f@ y(i-1) f@ f- fdup f* sumdydt^2 f@ f+ sumdydt^2 f!
        argmax f@ y(i-1) f!
      then
    2 series.fxy
  loop
endproc

proc report
  "sum of delta^2 " print sumdelta^2 f@ f. cr
  "sum of dy/dt^2 " print sumdydt^2 f@ f. cr
endproc

showdata

0.0 XMIN F!
10.0 XMAX F!
500 TO STEPS

CR
showaverage
"Average filt" print cr
report
bayesfilt
"Bayes filt" print cr
report


1 chart.show
0 800 2000 700 1 chart.rect
3 1 chart.addseries
4 1 chart.addseries
5 1 chart.addseries

3 3 series.linewidth
0x0 3 series.color
3 4 series.linewidth
0x0000ff 4 series.color

proc f(epsilon)
  3 series.clear
  4 series.clear
  21 1 do
    i s>f 0.1 f* epsilon f!
    bayesfilt
    sumdelta^2 f@
    sumdydt^2 f@
    3 series.fxy
    sumdelta^2 f@
    sumdydt^2 f@ sumdelta^2 f@ f+
    4 series.fxy
  loop
  0.0 0.0 5 series.fxy
endproc

f(epsilon)


