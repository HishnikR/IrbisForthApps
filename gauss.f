create xy[]
1.0 f, 4.0 f,
2.0 f, 5.0 f,
3.0 f, 4.0 f,
4.0 f, 4.0 f,
5.0 f, 5.0 f,
6.0 f, 4.0 f,
7.0 f, 6.0 f,
8.0 f, 5.0 f,
9.0 f, 6.0 f,
10.0 f, 7.0 f,
11.0 f, 6.0 f,
12.0 f, 5.0 f,
13.0 f, 6.0 f,
14.0 f, 7.0 f,
15.0 f, 6.0 f,

0 chart.show
0 chart.align.client


proc demo
"demo" print
10 0 do
  i 0 chart.addseries
  i series.clear
  i i series.linewidth
  100 0 do
    i s>f 0.1 f*
    xy[] 5 i s>f 0.1 f* j s>f 0.5 f* 2.5 3.0 FGAUSS[]2D j series.fxy
  loop
  loop
endproc

proc simple_gauss
  0 0 chart.addseries
  0 series.clear
  3 0 series.linewidth
  1000 0 do
    i 500 - s>f 0.01 f*
    fdup
    fdup f* -1.0 f* fexp
    0 series.fxy
  loop

  1 0 chart.addseries
  1 series.clear
  5 1 series.linewidth
  1000 0 do
    i 500 - s>f 0.01 f*
    fdup
    fdup f* 0.25 f* -1.0 f* fexp 0.5 f*
    1 series.fxy
  loop
endproc

proc equal_distribution
  0 0 chart.addseries
  0 series.clear
  3 0 series.linewidth
  1000 0 do
    i 500 - s>f 0.01 f*
    i 500 > i 700 < and if 0.1 else 0.0 then
    0 series.fxy
  loop
endproc

proc triangle_distribution
  0 0 chart.addseries
  0 series.clear
  3 0 series.linewidth
  1000 0 do
    i 500 - s>f 0.01 f*
    i 300 > i 500 < and if i 300 - s>f 0.0025 f* else 0.0 then
    i 499 > i 700 < and if fdrop 0.5 i 500 - s>f 0.0025 f* f- then
    0 series.fxy
  loop
endproc

proc maxwell_distribution
  0 0 chart.addseries
  0 series.clear
  3 0 series.linewidth
  1000 0 do
    i s>f 0.05 f*
    fdup 0.1 f* fdup f* -1.0 f* fexp
    i s>f 0.2 f* fdup f* f*
    0 series.fxy
  loop
endproc

proc mean
  0 0 chart.addseries
  0 series.clear
  5 0 series.linewidth
  10 0 do
    i s>f
    0.0
    5 0 do
      xy[]
      j i + 2 * 1 + -th f@
      f+
    loop
    5.0 f/
    0 series.fxy
  loop

  1 0 chart.addseries
  1 series.clear
  3 1 series.linewidth
  0.0 0.0 1 series.fxy
  15 0 do
    xy[] i 2 * -th f@
    xy[] i 2 * 1 + -th f@
    1 series.fxy
  loop

endproc

mean

