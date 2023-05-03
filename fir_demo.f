
4 CONSTANT #TAPS
CREATE K[] 2700 , 5302 , 5302 , 2700 ,
CREATE X[] 0 , 0 , 0 , 0 ,
int y

float ampl 100.0 ampl f!
float fs 1.0e6 fs f!
float f 1.0e5 f f!
int time

0 to time

: get-sample
  time s>f f f@ f* fs f@ f/ 2.0 f* 3.1415926 f* fsin ampl f@ f* f>s

  time 1 + to time
;

0 CHART.SHOW
0 CHART.ALIGN.CLIENT

0 0 CHART.ADDSERIES
0xFF00FF 0 SERIES.COLOR
3 0 series.linewidth

: step-fir
  0
  #taps 0 do
    k[] i -th @
    x[] i -th @ * +
  loop
  to y
  time y 0 series.xy
  #taps 1 - 0 do
    x[] #taps i - 2 - -th @
    x[] #taps i - 1 - -th !
  loop
  get-sample x[] !
;

: run
  0 to time
  0 series.clear
  1.0e3 f f!
  1000 0 do
    step-fir
    f f@ 2.5e2 f+ f f!
  loop
;

run


