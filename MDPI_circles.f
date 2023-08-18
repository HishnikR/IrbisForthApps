
0 IMAGE.SHOW
100 100 50 50 0 IMAGE.RECT
"circles_small.bmp" 0 IMAGE.LOAD

45 CONSTANT XSIZE
45 CONSTANT YSIZE

int POINTS

5000 constant maxpoints

create x[] maxpoints cells allot
create y[] maxpoints cells allot

proc count_pt
  0 to points
  ysize 0 do
    xsize 0 do
      i j 0 image.getpixel 16777215 < if
        i s>f x[] points -th f!
        j s>f y[] points -th f!
        points 1 + to points
      then
    loop
  loop
endproc

count_pt
points .

float R  10.0 R f!
float x0 22.5 x0 f!
float y0 22.5 y0 f!
float sigma 1.0 sigma f!

proc dist-circle // f : x, y - f: dist
  y0 f@ f- fdup f*
  fswap x0 f@ f- fdup f* f+ fsqrt
  R f@ f- fabs
endproc

proc p(x,y) // f : x, y -- f:p
   dist-circle
   fdup f*
   sigma f@ fdup f* f/ -1.0 f* fexp
endproc

proc p_all
  0.0
  points 0 do
    x[] i -th f@
    y[] i -th f@
    p(x,y)
    f+
  loop
endproc

0 chart.show
200 100 1000 500 0 chart.rect

int #series
0 to #series

proc run-r
  22.5 x0 f!
  22.5 y0 f!
  #series SERIES.CLEAR
  100 0 do
    i s>f 0.25 f* 1.0 f+ R f!
    R f@
    p_all
    #series series.fxy
  loop
endproc

proc run
  10 0 do
    i 0 chart.addseries
    i to #series
    i s>f 0.5 f* 0.5 f+ sigma f!
    run-r
  loop
endproc

run





