CREATE U1[]


int n1
int n2

"RRRC_U1.prn" 0 FILE.TEXT.OPEN DROP
0 U1[] FILE.TEXT.FXY to n1
0 file.text.close drop
n1 2 * floats allot


CREATE U2[]
"RRRC_U2.prn" 0 FILE.TEXT.OPEN DROP
0 U2[] FILE.TEXT.FXY to n2
0 file.text.close drop
n2 2 * floats allot


2500 constant t0

proc draw
0 0 chart.addseries
1 0 chart.addseries

0xff0000 1 series.color

0 series.clear
1 series.clear

0 chart.hide
  n1 10 / t0 + t0 do
    u1[] i 2 * -th f@
    u1[] i 2 * 1 + -th f@
    0 series.fxy
  loop

  n2 10 / t0 + t0 do
    u2[] i 2 * -th f@
    u2[] i 2 * 1 + -th f@
    1 series.fxy
  loop

0 chart.show
0 0 1000 400 0 chart.rect
endproc


proc draw-dt
2 1 chart.addseries
3 1 chart.addseries

0xff0000 3 series.color

2 series.clear
3 series.clear

1 chart.hide
  n1 20 / t0 + t0  do
    u1[] i 2 * -th f@
    u1[] i 50 + 2 * 1 + -th f@
    u1[] i 2 * 1 + -th f@ f-
    2 series.fxy
  loop

  n2 20 / t0 + t0  do
    u2[] i 2 * -th f@
    u2[] i 50 + 2 * 1 + -th f@
    u2[] i 2 * 1 + -th f@ f-
    3 series.fxy
  loop

1 chart.show
0 400 1000 400 1 chart.rect

endproc

draw
draw-dt
