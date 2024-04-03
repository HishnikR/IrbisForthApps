
100000 constant MAXSIZE


create signal[] MAXSIZE CELLS ALLOT
create wav_re[] MAXSIZE CELLS ALLOT
create wav_im[] MAXSIZE CELLS ALLOT

int n 1 to n

proc calc-wavelet // - wavre, wavim
  signal[]
  wav_re[]
  n
  [X*Y] // addr1, addr2, n – y –
  signal[]
  wav_im[]
  n
  [X*Y] // addr1, addr2, n – y –
endproc

float WAmpl 65536.0 WAmpl f!
float wav_k 135.0 wav_k f!

float Ampl 100.0 Ampl f!
float fs   1.0e6 fs f!
float f0   10.0e3 f0 f!
float phi0 0.0 phi0 f!

1000 to n

proc fill_demo
  0 series.clear
  n 2 * 1 + 0 do
    i n - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ phi0 f@ f+ fsin
    Ampl f@ f* f>s
    signal[] i -th !
    i signal[] i -th @ 0 series.xy
  loop

  1 series.clear
  2 series.clear
  n 2 * 1 + 0 do
    i n - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ phi0 f@ f+ fcos
    i n - s>f wav_k f@ f/ fdup f* -1.0 f* fexp f*
    WAmpl f@ f* f>s
    wav_re[] i -th !
    i wav_re[] i -th @ 1 series.xy

    i n - s>f 2.0 f* pi f* f0 f@ f* fs f@ f/ phi0 f@ f+ fsin
    i n - s>f wav_k f@ f/ fdup f* -1.0 f* fexp f*
    WAmpl f@ f* f>s
    wav_re[] i -th !
    i wav_re[] i -th @ 2 series.xy
  loop

endproc

0 PANEL.SHOW
0 30 250 200 0 PANEL.RECT
0 PANEL.ALIGN.LEFT
0 SPLITTER.SHOW
0 SPLITTER.ALIGN.LEFT

1 PANEL.SHOW
1 30 150 500 1 PANEL.RECT
1 PANEL.ALIGN.TOP


0 CHART.SHOW
0 0 chart.addseries
1 0 CHART.PARENT.PANEL
0 chart.align.client

1 chart.show
1 chart.align.client
1 1 chart.addseries
2 1 chart.addseries

0xFF00FF 1 SERIES.COLOR
3 1 SERIES.LINEWIDTH
0xFFFF00 2 SERIES.COLOR
3 2 SERIES.LINEWIDTH

0 LABEL.SHOW
10 10 130 25 0 LABEL.RECT
" Settings" 0 LABEL.TEXT
0 0 LABEL.PARENT.PANEL

0 BUTTON.SHOW
10 100 200 50 0 BUTTON.RECT
0 0 BUTTON.PARENT.PANEL

fill_demo


