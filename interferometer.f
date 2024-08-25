
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


x[] 10000  0 series.plotfx

1 chart.show
1 1 chart.addseries
y[] 10000  1 series.plotfx

0 0 1200 200 0 chart.rect
0 200 1200 200 1 chart.rect

2 chart.show
2 2 chart.addseries
3 2 chart.addseries
0 400 600 400 2 chart.rect
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
600 400 600 400 3 chart.rect
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

explorephase




