int size

create x[]
"E:\XSoft\VNIIFTRI\Sample2_channel1.txt" 0 file.text.open drop
0 x[] file.text.fx to size
size cells allot

create y[]
"E:\XSoft\VNIIFTRI\Sample2_channel2.txt" 0 file.text.open drop
0 y[] file.text.fx to size
size cells allot

size .

0 chart.show
0 0 chart.addseries


x[] 10000  0 series.plotfx

1 chart.show
1 1 chart.addseries
y[] 10000  1 series.plotfx

0 0 1200 200 0 chart.rect
0 200 1200 200 1 chart.rect

2 chart.show
2 2 chart.addseries
3 2 chart.addseries
0 400 1200 400 2 chart.rect
x[] y[] 5000 2 series.plotfxy


// x = x * cos - y * sin
// y = x * sin + y * cos

10000 constant tsize
create xt[] tsize cells allot
create yt[] tsize cells allot

variable phi

proc transform
  tsize 0 do
    x[] i -th f@ phi f@ fcos f*
    y[] i -th f@ phi f@ fsin f* f-
    xt[] i -th f!
    x[] i -th f@ phi f@ fsin f*
    y[] i -th f@ phi f@ fcos f* f+
    yt[] i -th f!
  loop
endproc

proc rotate // f: phi --
  phi f!
  transform
  3 series.clear
  xt[] yt[] tsize 3 series.plotfxy
endproc

float sumx
float sumy
float sumxy
float sumx2

int rsize
100000 to rsize

proc regressk
  0.0 sumx f!
  0.0 sumy f!
  0.0 sumxy f!
  0.0 sumx2 f!
  rsize 0 do
    x[] i -th f@ sumx f@ f+ sumx f!
    y[] i -th f@ sumy f@ f+ sumy f!
    x[] i -th f@ y[] i -th f@ f* sumxy f@ f+ sumxy f!
    x[] i -th f@ fdup f* sumx2 f@ f+ sumx2 f!
  loop
  sumxy f@ rsize s>f f* sumx f@ sumy f@ f* f-
  sumx2 f@ rsize s>f f* sumx f@ fdup f* f-
  f/
  cr
  "k=" print f.
  cr
endproc


regressk

