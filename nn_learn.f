
2 constant #X
2 constant #Y

2 constant #K

create x[] #X floats allot
create y[] #Y floats allot
create k[] #Y #K * floats allot

create y0[] #Y floats allot

proc calc
  #Y 0 do
    0.0
    #K 0 do
      x[] i -th f@
      k[] j #k * i + -th f@ f* f+
    loop
    fdup 0.0 f< if fdrop 0.0 then
    fdup 1.0 f> if fdrop 1.0 then
    y[] i -th f!
  loop
endproc

proc y?
  "y=" print
  #Y 0 do
    y[] i -th f@ f.
  loop
endproc

0.5 k[] f!
-0.5 k[] 1 -th f!
1.0 k[] 2 -th f!
-0.2 k[] 3 -th f!

proc input // f: x1, x2
  x[] 1 -th f!
  x[] f!
  calc
  y?
endproc

float learning-rate
0.1 learning-rate f!

proc learn-step // f: x1, x2, y01, y02 --
  y0[] 1 -th f!
  y0[] f!
  x[] 1 -th f!
  x[] f!
  calc
  #Y 0 do
    y[] i -th f@ y0[] i -th f@ f< if
      #k 0 do
        k[] j #k * i + -th f@
        learning-rate f@
        x[] i -th f@ 0.0 f< if -1.0 f* then
        f+ fdup 1.0 f> if fdrop 1.0 then
        k[] j #k * i + -th f!
      loop
    else
      #k 0 do
        k[] j #k * i + -th f@
        learning-rate f@
        x[] i -th f@ 0.0 f< not if -1.0 f* then
        f+ fdup -1.0 f< if fdrop -1.0 then
        k[] j #k * i + -th f!
      loop

    then
  loop
endproc

proc test
  0 chart.show
  0 chart.align.client

  0 0 CHART.ADDSERIES
  1 0 CHART.ADDSERIES
  2 0 CHART.ADDSERIES
  3 0 CHART.ADDSERIES

  0xFF00FF 0 SERIES.COLOR
  0x403FFF 1 SERIES.COLOR
  0xFF0000 2 SERIES.COLOR
  0x00FF00 3 SERIES.COLOR
  4 0 do
    i series.clear
    3 i series.linewidth
  loop

  4 0 do
    0.0 k[] i -th f!
  loop

  100 0 do
    1.0 1.0 0.0 1.0 learn-step
    4 0 do
      j s>f k[] i -th f@ i s>f 0.01 f* f+ i series.fxy
    loop
  loop

endproc
