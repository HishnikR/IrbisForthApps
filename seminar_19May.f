// 0 panel.show
// 0 0 100 800 0 panel.rect
// 0 panel.align.left

0 chart.show
100 0 1000 300 0 chart.rect
0 0 chart.addseries
3 0 series.linewidth

1 chart.show
100 300 1000 300 1 chart.rect
1 1 chart.addseries
2 1 chart.addseries
3 1 series.linewidth
0xff0000 1 series.color
3 2 series.linewidth
0x0000ff 2 series.color

2 chart.show
100 600 1000 300 2 chart.rect
3 2 chart.addseries
4 2 chart.addseries
3 3 series.linewidth
0xff0000 3 series.color
3 4 series.linewidth
0x0000ff 4 series.color

0 button.show
// 0 0 button.parent.panel
10 100 75 25 0 button.rect
"Signal" 0 button.text
"signal" 0 button.action

0 trackbar.show
// 0 trackbar.parent.panel
10 10 80 20 0 trackbar.rect
0 0 TRACKBAR.MIN
360 0 TRACKBAR.MAX
1 0 TRACKBAR.STEP
"0 TRACKBAR.GETPOSITION s>f 180.0 f/ pi f* phi0 f! signal mult" 0 TRACKBAR.ACTION

0 label.show
1100 600 200 50 0 label.rect
24 0 label.font.size
0xff0000 0 label.font.color

1 label.show
1100 650 200 50 1 label.rect
24 1 label.font.size
0x0000ff 1 label.font.color



float fs  1.0e6 fs f!

float f     1.0e3 f f!
float A     2047.0 A f!
float phi0  0.0 phi0 f!

float w     1.0e3 w f!

10000 constant SIGNALSIZE

int  WAVSIZE
10000 to WAVSIZE

float f1
float fstep
float kw

0.5e3 f1 f!
5.0e1 fstep f!

int wav0
0 to wav0

create signal[] SIGNALSIZE cells allot

create WRE[] WAVSIZE 20 * cells allot
create WIM[] WAVSIZE 20 * cells allot

proc signal
  0 series.clear

  SIGNALSIZE 0 do
    i s>f f f@ fs f@ f/ f* 2.0 f* pi f* phi0 f@ f+ fsin A f@ f* f>s
    dup
    signal[] i -th !
    i swap 0 series.xy
  loop

endproc

signal

proc gen-sin

  WAVSIZE 0 do
    i s>f w f@ fs f@ f/ f* 2.0 f* pi f* fcos
    WRE[] i -th f!
    i s>f w f@ fs f@ f/ f* 2.0 f* pi f* fsin
    WIM[] i -th f!
  loop
endproc

proc wavdraw
  1 series.clear
  2 series.clear
  WAVSIZE 0 do
    i s>f
    WRE[] i -th f@
    1 series.fxy
    i s>f
    WIM[] i -th f@
    2 series.fxy
  loop
endproc


proc get-k
  3.5 6.4582 f* 3.7895 f+
endproc

get-k kw f!

proc gen-wav
   // fs f@ w f@ f/ 7.0 f* f>s 1 + to WAVSIZE
   WAVSIZE 0 do
      i WAVSIZE 2 / - s>f w f@ fs f@ f/ f* 2.0 f* pi f* fcos
      i WAVSIZE 2 / - s>f w f@ fs f@ f/ f* 2.0 f* pi f* fdup f* kw f@ f/ -1.0 f* fexp f*
      WRE[] i -th f!
      i WAVSIZE 2 / - s>f w f@ fs f@ f/ f* 2.0 f* pi f* fsin
      i WAVSIZE 2 / - s>f w f@ fs f@ f/ f* 2.0 f* pi f* fdup f* kw f@ f/ -1.0 f* fexp f*
      WIM[] i -th f!
   loop
endproc

gen-sin wavdraw

float sre
float sim

proc mult
   3 series.clear
   4 series.clear
   0.0 sre f!
   0.0 sim f!
   WAVSIZE 0 do
     i s>f
     signal[] i -th @ s>f
     WRE[] i -th f@ f*
     fdup sre f@ f+ sre f!
     3 series.fxy

     i s>f
     signal[] i -th @ s>f
     WIM[] i -th f@ f*
     fdup sim f@ f+ sim f!
     4 series.fxy
   loop
   0 label.show
   1100 600 200 50 0 label.rect
   1 label.show
   1100 650 200 50 1 label.rect
   sre f@ 0 label.float
   sim f@ 1 label.float
endproc

100 constant SPECTRS




proc spectr
  3 series.clear
  4 series.clear
  0.5e3 w f!
  0.01e3 fstep f!
  SPECTRS 0 do
  gen-sin
    0.0 sre f!
    0.0 sim f!
    WAVSIZE 0 do
      signal[] i -th @ s>f
      WRE[] i -th f@ f*
      sre f@ f+ sre f!

      signal[] i -th @ s>f
      WIM[] i -th f@ f*
      sim f@ f+ sim f!
    loop
    w f@
    sre f@ fdup f* sim f@ fdup f* f+ fsqrt 3 series.fxy
    w f@ fstep f@ f+ w f!
  loop
endproc


proc wspectr
  3 series.clear
  4 series.clear
  0.5e3 w f!
  0.01e3 fstep f!
  SPECTRS 0 do
  gen-wav
    0.0 sre f!
    0.0 sim f!
    WAVSIZE 0 do
      signal[] i -th @ s>f
      WRE[] i -th f@ f*
      sre f@ f+ sre f!

      signal[] i -th @ s>f
      WIM[] i -th f@ f*
      sim f@ f+ sim f!
    loop
    w f@
    sre f@ fdup f* sim f@ fdup f* f+ fsqrt w f@ f* 3 series.fxy
    w f@ fstep f@ f+ w f!
  loop
endproc



