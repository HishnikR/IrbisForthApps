
0 CHART.SHOW
0 CHART.ALIGN.CLIENT

0 0 CHART.ADDSERIES
0x0000FF 0 SERIES.COLOR
3 0 series.linewidth

1 0 CHART.ADDSERIES
0x00FF00 1 SERIES.COLOR
3 1 series.linewidth


int C  16 to C
int P  16 to P

int ng  2 to ng
int N  1 to N
int b  512 to b

int Tsw 1000000 to Tsw
int Tq  1024 to Tq

proc calcA // -- A
  C P < if C else P then
  Tsw *
  Tsw N * ng /
  Tq b / +
  /
endproc

proc draw0
  0 series.clear
  0 0 0 series.xy
  16 to C
  1 to ng
  1024 to Tq
  128 16 do
    i to b
    i calcA 0 series.xy
  4 +loop
endproc

proc draw1
  1 series.clear
  0 0 1 series.xy
  16 to C
  8 to ng
  1024 to Tq
  128 16 do
    i to b
    i calcA 1 series.xy
  4 +loop
endproc



proc draw2
  0 series.clear
  0 0 0 series.xy
  16 to C
  1 to ng
  1024 to Tq
  128 16 do
    i to b
    i calcA 0 series.xy
  4 +loop
endproc

proc draw3
  1 series.clear
  0 0 1 series.xy
  16 to C
  1 to ng
  8 to Tq
  128 16 do
    i to b
    i calcA 1 series.xy
  4 +loop
endproc



proc draw4
  0 series.clear
  0 0 0 series.xy
  16 to C
  1 to ng
  256 to Tq
  128 16 do
    i to b
    i calcA 0 series.xy
  4 +loop
endproc

proc draw5
  1 series.clear
  0 0 1 series.xy
  128 to C
  8 to ng
  256 to Tq
  128 16 do
    i to b
    i calcA 1 series.xy
  4 +loop
endproc

draw4
draw5
