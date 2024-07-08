
100000 constant MAXSIZE

create signal[] MAXSIZE CELLS ALLOT
create wav_re[] MAXSIZE CELLS ALLOT
create wav_im[] MAXSIZE CELLS ALLOT

int n

proc calc-wavelet // - wavre, wavim
  signal[]
  wav_re[]
  n 2 * // 1 +
  [X*Y] // addr1, addr2, n – y –
  signal[]
  wav_im[]
  n 2 * // 1 +
  [X*Y] // addr1, addr2, n – y –
endproc

float periods 27.0 periods f!


float WAmpl 2.0e10 WAmpl f!
float wav_k 319.35 wav_k f!

float Ampl 32767.0 Ampl f!
float fs   1.0e6 fs f!
float f0   1.0e3 f0 f!
float phi0 0.0 phi0 f!

periods f@ 2.0 f/ fs f@ f* f0 f@ f/ f>s  to n

int ?noise 0 to ?noise

int re
int im

proc fill-signal
  n 2 * 2 + 0 do
    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ phi0 f@ f+ fcos
    Ampl f@ f* f>s

    ?noise if random 20 mod + then

    signal[] i -th !
  loop
endproc

proc fill_demo
  0 series.clear
  n 2 * 2 + 0 do
    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ phi0 f@ f+ fcos
    Ampl f@ f* f>s
    signal[] i -th !
    i signal[] i -th @ 0 series.xy
  loop

  1 series.clear
  2 series.clear
  n 2 * 2 + 0 do
    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ fcos
    i n - 1 -  s>f wav_k f@ f/ fdup f* -1.0 f* fexp f*
    WAmpl f@ f* f>s
    wav_re[] i -th !
    i wav_re[] i -th @ 1 series.xy

    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ fsin
    i n - 1 - s>f wav_k f@ f/ fdup f* -1.0 f* fexp f*
    WAmpl f@ f* f>s
    wav_im[] i -th !
    i wav_im[] i -th @ 2 series.xy
  loop

  "summas: " print
  wav_re[] n 2 * 1 + [SUM] .
  wav_im[] n 2 * 1 + [SUM] .

endproc


proc fill-sinus
  n 2 * 2 + 0 do
    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ phi0 f@ f- fcos
    Ampl f@ f* f>s
    signal[] i -th !

    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ fcos
    WAmpl f@ f* f>s
    wav_re[] i -th !

    i n - 1 - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ fsin
    WAmpl f@ f* f>s
    wav_im[] i -th !
  loop
endproc

proc fourier
  0 series.clear
    0 CHART.SHOW
  0 0 chart.addseries
  3 0 SERIES.LINEWIDTH
  0 chart.align.client
  90 0 do
     i s>f pi f* 180.0 f/ phi0 f!
     fill-sinus
     calc-wavelet
     s>f s>f
     i . " " print fpatan phi0 f@ f- fdup f. cr
     i s>f fswap 0 series.fxy
  loop
endproc





proc panel0

  0 PANEL.SHOW
  0 30 250 200 0 PANEL.RECT
  0 PANEL.ALIGN.LEFT
  0 SPLITTER.SHOW
  0 SPLITTER.ALIGN.LEFT

  0 CHART.SHOW
  0 0 chart.addseries
  3 0 SERIES.LINEWIDTH
  1 0 CHART.PARENT.PANEL
  0 chart.align.client
endproc

proc panel1
1 PANEL.SHOW
1 30 150 500 1 PANEL.RECT
1 PANEL.ALIGN.TOP

1 chart.show
1 chart.align.client
1 1 chart.addseries
2 1 chart.addseries

0xFF00FF 1 SERIES.COLOR
3 1 SERIES.LINEWIDTH
0xFF7F00 2 SERIES.COLOR
3 2 SERIES.LINEWIDTH

endproc

0 LABEL.SHOW
10 10 130 25 0 LABEL.RECT
" Settings" 0 LABEL.TEXT
0 0 LABEL.PARENT.PANEL

0 BUTTON.SHOW
10 100 200 50 0 BUTTON.RECT
0 0 BUTTON.PARENT.PANEL


: explore_phi
  1 series.clear
  2 series.clear
  100 0 do
    i s>f 100.0 f/ phi0 f!
    fill-signal
    calc-wavelet
    s>f s>f fpatan -1.0 f*
    phi0 f@ f-
    phi0 f@ fswap
    1 series.fxy
  loop

  1 to ?noise
  100 0 do
    i s>f 100.0 f/ phi0 f!
    fill-signal
    calc-wavelet
    s>f s>f fpatan -1.0 f*
    phi0 f@ f-
    phi0 f@ fswap
    2 series.fxy
  loop
;


// fill_demo
// calc-wavelet . .

fourier



