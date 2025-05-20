
int size

create x[]
"delta_ticks.txt" 0 file.text.open drop
0 x[] file.text.x to size
size cells allot

size .

0 chart.show
0 0 chart.addseries
1 0 chart.addseries
2 0 chart.addseries

3 1 SERIES.LINEWIDTH
0xFF0000 1 SERIES.COLOR

3 2 SERIES.LINEWIDTH
0x0000FF 2 SERIES.COLOR

x[] size  0 series.plotx

int DATASIZE



create Y[] 100 FLOATS ALLOT
50 to DATASIZE

FLOAT SIGMA
FLOAT SIGMA0
FLOAT EPSILON

FLOAT X
FLOAT Y

1.0 SIGMA0 F!
0.10 EPSILON F!


PROC P(X) // -- FF: P
  0.0
  DATASIZE 0 DO
    Y F@ Y[] I -TH F@ F-

    DATASIZE I - S>F
    EPSILON F@ F*
    SIGMA0 F@ F+
    FGAUSS F+
  LOOP
ENDPROC

FLOAT YMIN
FLOAT YMAX
FLOAT YSTEP
FLOAT PMAX
FLOAT ARGMAX
INT NMAX

0.0 YMIN F!
20.0 YMAX F!
0.1 YSTEP F!

FLOAT P1
FLOAT P2
FLOAT P3


PROC SCAN
  0 TO NMAX
  0.0 P1 F!
  0.0 P2 F!
  0.0 P3 F!
  YMIN F@ ARGMAX F!
  0.0 PMAX F!
  YMIN F@ Y F!
  BEGIN
    P(X)
    FDUP P3 F!
    P2 F@ P1 F@ F>
    P2 F@ P3 F@ F> AND IF
      NMAX 1 + TO NMAX
    THEN
    P2 F@ P1 F!
    P3 F@ P2 F!

    FDUP PMAX F@ F> IF
      FDUP PMAX F!
      Y F@ ARGMAX F!
    THEN

    FDROP
    Y F@ YSTEP F@ F+ Y F!

  Y F@ YMAX F@ F>  UNTIL

ENDPROC


PROC SCANSIGMA
  1.0 SIGMA0 F!
  BEGIN
    SCAN
    SIGMA0 F@ 1.5 F* SIGMA0 F!
  NMAX 1 = UNTIL


ENDPROC


0 CHART.SHOW
0 CHART.ALIGN.CLIENT


PROC RUN
1 SERIES.CLEAR
0.10 EPSILON F!

100 0 DO

  DATASIZE 0 DO
    X[] J 50 * I + -TH @ S>F
    Y[] I -TH F!
  LOOP

  0.0 YMIN F!
  200.0 YMAX F!
  0.1 YSTEP F!
  SCANSIGMA
  I 50 * DATASIZE 2 / + S>F
  ARGMAX F@
  1 SERIES.FXY

LOOP


2 SERIES.CLEAR
1.0 EPSILON F!

100 0 DO

  DATASIZE 0 DO
    X[] J 50 * I + -TH @ S>F
    Y[] I -TH F!
  LOOP

  0.0 YMIN F!
  200.0 YMAX F!
  0.1 YSTEP F!
  SCANSIGMA
  I 50 * DATASIZE 2 / + S>F
  ARGMAX F@
  2 SERIES.FXY

LOOP


ENDPROC

RUN


