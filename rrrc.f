

float t
float dt
float R1
float R2
float R3
float C1
float C2
float V0
float V1
float V2
float I2

int #series

2.50 V0 f!
1.0e-7 dt f!
0.0 t f!
1029.0 50.0 f+ R1 f!
1073.0 R2 f!
1000.0 R3 f!
1.0e-6 C1 f!
0.47e-6 C2 f!

float dV1
float dV2

proc step
  V1 f@ V2 f@ f-
  R2 f@ f/ fdup I2 f!
  V2 f@ R3 f@ f/ f-
  C2 f@ f/
  dt f@ f*
  dV2 f!

  V0 f@ V1 f@ f-
  R1 f@ f/ I2 f@ f-

  C1 f@ f/
  dt f@ f*
  dV1 f!

  V1 f@ dV1 f@ f+ V1 f!
  V2 f@ dV2 f@ f+ V2 f!

  t f@ dt f@ f+ t f!
endproc

50000 constant PERIOD

proc run
 0.0 t f!
 3.0 V0 f!
 0.0 V1 f!
 0.0 V2 f!
 PERIOD 0 do
   step
   i 100 mod 0 = if
     i s>f dt f@ f* 1.0e-9 f/ V1 f@ 4 series.fxy
     i s>f dt f@ f* 1.0e-9 f/ V2 f@ 5 series.fxy
   then
 loop

endproc

proc run-dt
 0.0 t f!
 3.0 V0 f!
 0.0 V1 f!
 0.0 V2 f!
 PERIOD 0 do
   step
   i 100 mod 0 = if
     i 100 / s>f dV1 f@ dt f@ f/ 5000.0 f/ 6 series.fxy
     i 100 / s>f  dV2 f@ dt f@ f/ 5000.0 f/ 7 series.fxy
   then
 loop

endproc

CREATE U1[]
200000 floats allot

int n1
int n2
int n3

create u1u2[]
"rrrc.txt" 0 FILE.TEXT.OPEN DROP
0 U1u2[] FILE.TEXT.FXYZ to n3
0 file.text.close drop
200000 floats allot


755 constant toffset


proc conv
  10000 0 do
    i 10000 * s>f
    u1[] i 2 * -th f!
    u1u2[] i toffset + 3 * 1 + -th f@
    u1[] i 2 * 1 + -th f!

    i 10000 * s>f
    u2[] i 2 * -th f!
    u1u2[] i toffset + 3 * 2 + -th f@
    u2[] i 2 * 1 + -th f!
  loop
  5000 to n1
  5000 to n2
endproc

conv

0 constant t0

proc draw
0 0 chart.addseries
1 0 chart.addseries

4 0 chart.addseries
5 0 chart.addseries

0xff0000 1 series.color

0x00ff00 4 series.color
0x008080 5 series.color

0 series.clear
1 series.clear
2 series.clear
3 series.clear
4 series.clear
5 series.clear

0 chart.hide
  n1 10 / 0 do
    u1[] i 2 * -th f@
    u1[] i 2 * 1 + -th f@
    0 series.fxy
  loop

  n2 10 / 0 do
    u2[] i 2 * -th f@
    u2[] i 2 * 1 + -th f@
    1 series.fxy
  loop

  run

0 chart.show
0 0 1000 400 0 chart.rect
endproc


proc draw-dt
2 1 chart.addseries
3 1 chart.addseries
6 1 chart.addseries
7 1 chart.addseries

0xff0000 3 series.color

2 series.clear
3 series.clear
6 series.clear
7 series.clear

1 chart.hide
  n1 20 / t0 + t0  do
    i t0 - s>f
    u1[] i 25 + 2 * 1 + -th f@
    u1[] i 2 * 1 + -th f@ f-
    2 series.fxy
  loop

  n2 20 / t0 + t0  do
    i t0 - s>f
    u2[] i 25 + 2 * 1 + -th f@
    u2[] i 2 * 1 + -th f@ f-
    3 series.fxy
  loop

  run-dt

1 chart.show
0 400 1000 400 1 chart.rect

endproc

draw
draw-dt
