

float t
float dt
float R1
float R2
float R3
float C1
float C2
float V0
float V1
float V2
float I2

int #series

5.0 V0 f!
1.0e-8 dt f!
0.0 t f!
1000.0 R1 f!
1000.0 R2 f!
1000.0 R3 f!
1.0e-6 C1 f!
0.33e-6 C2 f!

float dV1
float dV2

proc step
  V1 f@ V2 f@ f-
  R2 f@ f/ fdup I2 f!
  V2 f@ R3 f@ f/ f-
  C2 f@ f/
  dt f@ f*
  dV2 f!

  V0 f@ V1 f@ f-
  R1 f@ f/ I2 f@ f-


  C1 f@ f/
  dt f@ f*
  dV2 f@ f-
  dV1 f!

  V1 f@ dV1 f@ f+ V1 f!
  V2 f@ dV2 f@ f+ V2 f!

  t f@ dt f@ f+ t f!
endproc

1000000 constant PERIOD

proc run
 0.0 t f!
 5.0 V0 f!
 0.0 V1 f!
 0.0 V2 f!
 PERIOD 0 do
   step
   t f@ V1 f@ 0 series.fxy
   t f@ V2 f@ 1 series.fxy
 loop
 0.0 V0 f!
 PERIOD 0 do
   step
   t f@ V1 f@ 0 series.fxy
   t f@ V2 f@ 1 series.fxy
 loop
endproc


0 chart.show
0 chart.align.client
0 0 chart.addseries
1 0 chart.addseries

5 0 series.linewidth
4 1 series.linewidth

0 series.clear
1 series.clear

run


