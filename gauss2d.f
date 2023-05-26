create xy[]
1.0 f, 1.0 f,
2.0 f, 2.0 f,
3.0 f, 3.0 f,
4.0 f, 4.0 f,
5.0 f, 5.0 f,

0 chart.show


proc demo
"demo" print
10 0 do
  i 0 chart.addseries
  i series.clear
  i i series.linewidth
  100 0 do
    i s>f 0.1 f*
    xy[] 5 i s>f 0.1 f* j s>f 0.5 f* 2.5 FGAUSS[]2D j series.fxy
  loop
  loop
endproc

demo
