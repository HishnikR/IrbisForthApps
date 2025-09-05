
200000 constant fclk

1200 constant f0
2200 constant f1

int wre
int wim

int wre1
int wim1


int fhart
f0 to fhart

// 83 constant TLIM
// 167 constant WSIZE

167 7 * constant TLIM
167 14 * constant WSIZE

167 constant SYMSIZE

30 constant PERIODS

: FAMPL 255.0 ;
float phase
45.0 180.0 f/ pi f* phase f!

create re[] WSIZE CELLS ALLOT
create im[] WSIZE CELLS ALLOT

create re1[] WSIZE CELLS ALLOT
create im1[] WSIZE CELLS ALLOT

create x1[] WSIZE CELLS ALLOT

int x[] x1[] to x[]

create signal[] WSIZE PERIODS * CELLS ALLOT

float kw

: get-k
  13.5 6.4582 f* 3.7895 f+
;

get-k kw f!

proc wav()
  0 to wre
  0 to wim
  0 to wre1
  0 to wim1
  WSIZE 0 do
    x[] i -th @
    re[] i -th @ *
    wre + to wre
    x[] i -th @
    im[] i -th @ *
    wim + to wim
    x[] i -th @
    re1[] i -th @ *
    wre1 + to wre1
    x[] i -th @
    im1[] i -th @ *
    wim1 + to wim1
  loop
endproc

proc createwav()
  WSIZE 0 do
    f0 s>f fclk s>f f/ i TLIM - s>f f* 2.0 f* pi f* fcos FAMPL f*
    f0 s>f fclk s>f f/ i TLIM - s>f f* 2.0 f* pi f* fdup f* kw f@ f/ fabs fexp f/
    f>s re[] i -th !
    f0 s>f fclk s>f f/ i TLIM - s>f f* 2.0 f* pi f* fsin FAMPL f*
    f0 s>f fclk s>f f/ i TLIM - s>f f* 2.0 f* pi f* fdup f* kw f@ f/ fabs fexp f/
    f>s im[] i -th !
    f1 s>f fclk s>f f/ i TLIM - s>f f* 2.0 f* pi f* fcos FAMPL f*
    f0 s>f fclk s>f f/ i TLIM - s>f f* 2.0 f* pi f* fdup f* kw f@ f/ fabs fexp f/
    f>s re1[] i -th !
    f1 s>f fclk s>f f/ i TLIM - s>f f* 2.0 f* pi f* fsin FAMPL f*
    f0 s>f fclk s>f f/ i TLIM - s>f f* 2.0 f* pi f* fdup f* kw f@ f/ fabs fexp f/
    f>s im1[] i -th !
  loop
endproc

proc generate()
  SYMSIZE 0 do
    fhart s>f fclk s>f f/ i SYMSIZE 2 / - s>f f* 2.0 f* pi f* phase f@ f- fcos FAMPL f* f>s

    10000 s>f fclk s>f f/ i SYMSIZE 2 / - s>f f* 2.0 f* pi f* phase f@ f- fcos 25.0 f* f>s +

    random abs 10 mod 0 = if
      random abs 100 mod 50 - +
    then

    x[] i -th !
  loop
endproc

: setf0 f0 to fhart ;
: setf1 f1 to fhart ;

proc fill
  PERIODS 0 do
    setf0
    signal[] i SYMSIZE * cells + to x[]
    generate()
  loop
  setf1
  signal[] PERIODS 2 / SYMSIZE * cells + to x[]
  generate()
endproc

fill

0 chart.show
0 0 chart.addseries
0xffff00 0 series.color
1 0 chart.addseries
0xff00ff 1 series.color
2 0 chart.addseries

1 chart.show
0 500 500 500 1 chart.rect
3 1 chart.addseries
4 1 chart.addseries
5 1 chart.addseries

proc drawwav()
  0 series.clear
  1 series.clear
  WSIZE 0 do
    i
    re[] i -th @ 0 series.xy
    i
    im[] i -th @ 1 series.xy
  loop
endproc

proc drawx()
  2 series.clear
  WSIZE 0 do
    i
    x[] i -th @ 2 series.xy
  loop
endproc

proc run
  cr
  createwav()
  drawwav()
  generate()
  drawx()
  wav()
  3 series.clear
  0 0 3 series.xy
  wre wim 3 series.xy
  0 0 3 series.xy
  wre1 wim1 3 series.xy

  4 series.clear
  wre abs wim abs max wre1 abs max wim1 abs max dup 4 series.xy
endproc

proc getphase
  0 trackbar.getposition s>f 180.0 f/ pi f* phase f!
  run
endproc

0 trackbar.show
0 10 1000 50 0 trackbar.rect
0 0 trackbar.min
360 0 trackbar.max
"getphase" 0 trackbar.action

0 button.show
1000 50 100 30 0 button.rect
"f0" 0 button.text
"setf0" 0 button.action

1 button.show
1200 50 100 30 1 button.rect
"f1" 1 button.text
"setf1" 1 button.action

run

2 chart.show
700 500 500 500 2 chart.rect
6 2 chart.addseries
7 2 chart.addseries
0xff0000 6 series.color
0x00ff00 7 series.color

3 chart.show
700 100 500 300 3 chart.rect
8 3 chart.addseries

proc drawall()
  8 series.clear
  PERIODS WSIZE * 0 do
    i
    signal[] i -th @ 8 series.xy
  loop
endproc

drawall()

proc test()
  createwav()
  6 series.clear
  7 series.clear
  PERIODS 1 - WSIZE * 0 DO
    signal[] i cells + to x[]
    wav()
    i s>f
    wre s>f fdup f* wim s>f fdup f* f+ fsqrt 6 series.fxy
    i s>f
    wre1 s>f fdup f* wim1 s>f fdup f* f+ fsqrt 7 series.fxy
  100 +loop
endproc

test()

