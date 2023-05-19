
float phi
float d


float x0
float y0

float vx
float vy
float vcos
float vsin

proc rotate // f: x, y  -- f: x, y
  phi f@ fdup
  fcos vcos f!
  fsin vsin f!
  vy f!
  vx f!
  vx f@ vcos f@ f* vy f@ vsin f@ f* f-
  vx f@ vsin f@ f* vy f@ vcos f@ f* f+
endproc

proc move // f: x, y, -- f: x, y
  vy f!
  vx f!
  vx f@ d f@ vsin f@ f* f+
  vy f@ d f@ vcos f@ f* f-
endproc

0 chart.show
400 150 900 700 0 chart.rect

0 0 CHART.ADDSERIES
-10.0 -10.0 0 series.fxy
10.0 10.0 0 series.fxy

1 0 CHART.ADDSERIES
0xFF00FF 1 SERIES.COLOR
3 1 SERIES.LINEWIDTH
0.0 phi f!

proc redraw-line
  0 TRACKBAR.GETPOSITION s>f
  180.0 f/ pi f* phi f!
  1 TRACKBAR.GETPOSITION s>f
  9.0 f/ 5.0 f- d f!
  1 series.clear
  -10.0 0.0 rotate move
  1 series.fxy
  10.0 0.0 rotate move
  1 series.fxy
endproc

0 trackbar.show
400 50 900 30 0 trackbar.rect
90 0 trackbar.max
"redraw-line" 0 trackbar.action

1 trackbar.show
400 100 900 30 1 trackbar.rect
90 1 trackbar.max
"redraw-line" 1 trackbar.action

  0 STRINGGRID.SHOW
  10 150 350 700 0 STRINGGRID.RECT
  2 0 STRINGGRID.COLS
  0 0 STRINGGRID.COLS.FIXED
  0 0 STRINGGRID.ROWS.FIXED
  1 0 STRINGGRID.EDIT

0 button.show
10 900 100 50 0 button.rect
"Clear" 0 button.text
"0 stringgrid.clear" 0 button.action

