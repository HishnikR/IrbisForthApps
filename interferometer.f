
int size

create x[]
//  "E:\XSoft\VNIIFTRI\Sample2_channel1.txt" 0 file.text.open drop
//  0 x[] file.text.fx to size
  "E:\XSoft\VNIIFTRI\Sample1_channel_1.txt" 0 file.text.open drop
  0 x[] file.text.x to size
size cells allot

create y[]
//  "E:\XSoft\VNIIFTRI\Sample2_channel2.txt" 0 file.text.open drop
//  0 y[] file.text.fx to size
  "E:\XSoft\VNIIFTRI\Sample1_channel_2.txt" 0 file.text.open drop
  0 y[] file.text.x to size
size cells allot

size .

proc convert
"E:\XSoft\VNIIFTRI\channel_x.bin" 0 FILE.BIN.OPENW
0 x[] size cells FILE.BIN.WRITE
0 FILE.BIN.CLOSE

"E:\XSoft\VNIIFTRI\channel_y.bin" 0 FILE.BIN.OPENW
0 y[] size cells FILE.BIN.WRITE
0 FILE.BIN.CLOSE

endproc


int n
int signal[]

100000 constant MAXSIZE
create wav_re[] MAXSIZE CELLS ALLOT
create wav_im[] MAXSIZE CELLS ALLOT

proc calc-wavelet // - wavre, wavim
  signal[]
  wav_re[]
  n 2 * 1 +
  [FX*FY] // addr1, addr2, n – y –
  signal[]
  wav_im[]
  n 2 * 1 +
  [FX*FY] // addr1, addr2, n – y –
endproc


proc calc-im // shift - wavim
  cells
  signal[] +
  wav_im[]
  n 2 * 1 +
  [FX*FY] // addr1, addr2, n – y –
endproc

float periods 27.0 periods f!


float WAmpl 1.0e6  WAmpl f!
float wav_k 319.35 wav_k f!

float Ampl 0x200000 s>f Ampl f!
float fs   1.0e6 fs f!
float f0   10.0e3 f0 f!
float phi0 0.0 phi0 f!

periods f@ 2.0 f/ fs f@ f* f0 f@ f/ f>s  to n

int re
int im

proc fill_demo
  n 2 * 2 + 0 do
    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ fcos
    i n - 1 -  s>f wav_k f@ f/ fdup f* -1.0 f* fexp f*
    WAmpl f@ f*
    wav_re[] i -th f!

    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ fsin
    i n - 1 - s>f wav_k f@ f/ fdup f* -1.0 f* fexp f*
    WAmpl f@ f*
    wav_im[] i -th f!
  loop

  "k= " print wav_k f@ f.
  " summas: " print
  wav_re[] n 2 * 1 + [FSUM] f.
  wav_im[] n 2 * 1 + [FSUM] f.
  cr

endproc

fill_demo

proc fk
  100 0 do
    fill_demo
    wav_k f@ 0.01 f+ wav_k f!
  loop
endproc


0 chart.show
0 0 chart.addseries


x[] 10000000  0 series.plotx

1 chart.show
1 1 chart.addseries
y[] 10000000  1 series.plotx

0 0 1200 200 0 chart.rect
0 200 1200 200 1 chart.rect

2 chart.show
2 2 chart.addseries
3 2 chart.addseries
0 400 600 300 2 chart.rect
x[] y[] 220000 2 series.plotxy


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
1000000 to rsize
int start 0 to start

proc regressk
  0.0 sumx f!
  0.0 sumy f!
  0.0 sumxy f!
  0.0 sumx2 f!
  rsize 0 do
    x[] start i + -th f@ sumx f@ f+ sumx f!
    y[] start i + -th f@ sumy f@ f+ sumy f!
    x[] start i + -th f@ y[] start i + -th f@ f* sumxy f@ f+ sumxy f!
    x[] start i + -th f@ fdup f* sumx2 f@ f+ sumx2 f!
  loop
  sumxy f@ rsize s>f f* sumx f@ sumy f@ f* f-
  sumx2 f@ rsize s>f f* sumx f@ fdup f* f-
  f/
endproc


3 chart.show
600 400 600 300 3 chart.rect
4 3 chart.addseries
5 3 chart.addseries

proc explorek
  4 series.clear
  50 0 do
    i 1000000 * to start
    i s>f
    regressk
    4 series.fxy
  loop
endproc

proc explorephase
4 series.clear
5 series.clear
100 0 do
  x[] i 800000 * + to signal[]
  calc-wavelet fswap fpatan

  y[] i 800000 * + to signal[]
  calc-wavelet fswap fpatan f-
  i s>f fswap
  4 series.fxy
loop
endproc

float Ax
float Ay
float Dx
float Dy
float dphase

: >rad 180.0 f/ pi f* ;

proc draw-Lissajous
  3 series.clear
  0x0000ff 3 series.color
  3 3 series.linewidth
  360 0 do
     i s>f >rad fsin Ax f@ f* Dx f@ f+
     i s>f dphase f@ f+ >rad fsin Ay f@ f* Dy f@ f+
     3 series.fxy
  loop
endproc

proc update
  0 TRACKBAR.GETPOSITION S>F Ax f!
  1 TRACKBAR.GETPOSITION S>F Ay f!
  2 TRACKBAR.GETPOSITION 250 - S>F Dx f!
  3 TRACKBAR.GETPOSITION 250 - S>F Dy f!
  4 TRACKBAR.GETPOSITION 250 - S>F dphase f!

  "Ax= " PRINT Ax f@ f. cr
  "Ay= " PRINT Ay f@ f. cr
  "Dx= " PRINT Dx f@ f. cr
  "Dy= " PRINT Dy f@ f. cr
  "Delta phase= " PRINT dphase f@ f. cr

  draw-Lissajous
endproc


0 TRACKBAR.SHOW
0 700 500 30 0 TRACKBAR.RECT
0 0 TRACKBAR.MIN
500 0 TRACKBAR.MAX
25 0 TRACKBAR.STEP
"update" 0 TRACKBAR.ACTION

1 TRACKBAR.SHOW
550 700 500 30 1 TRACKBAR.RECT
0 1 TRACKBAR.MIN
500 1 TRACKBAR.MAX
25 1 TRACKBAR.STEP
"update" 1 TRACKBAR.ACTION

2 TRACKBAR.SHOW
0 750 500 30 2 TRACKBAR.RECT
0 2 TRACKBAR.MIN
500 2 TRACKBAR.MAX
25 2 TRACKBAR.STEP
"update" 2 TRACKBAR.ACTION

3 TRACKBAR.SHOW
550 750 500 30 3 TRACKBAR.RECT
0 3 TRACKBAR.MIN
500 3 TRACKBAR.MAX
25 3 TRACKBAR.STEP
"update" 3 TRACKBAR.ACTION

4 TRACKBAR.SHOW
0 800 500 30 4 TRACKBAR.RECT
0 4 TRACKBAR.MIN
500 4 TRACKBAR.MAX
25 4 TRACKBAR.STEP
"update" 4 TRACKBAR.ACTION



