float k1
float k2

float x1
float x2

float y

0 label.show
600 50 200 50 0 label.rect

1 label.show
600 150 200 50 1 label.rect

2 label.show
600 250 200 50 2 label.rect

3 label.show
600 350 200 50 3 label.rect

proc neuron // -- y
  k1 f@ x1 f@ f*
  k2 f@ x2 f@ f* f+

  fdup 1.0 f> if fdrop 1.0 then
  fdup 0.0 f< if fdrop 0.0 then
  100.0 f* f>s
endproc

proc calc_xor
  0 trackbar.getposition
  s>f 100.0 f/ k1 f!
  1 trackbar.getposition
  s>f 100.0 f/ k2 f!

  0.0 x1 f! 0.0 x2 f! neuron 0 label.int
  0.0 x1 f! 1.0 x2 f! neuron 1 label.int
  1.0 x1 f! 0.0 x2 f! neuron 2 label.int
  1.0 x1 f! 1.0 x2 f! neuron 3 label.int

endproc

0 TRACKBAR.SHOW
0 300 500 30 0 TRACKBAR.RECT
0 0 TRACKBAR.MIN
100 0 TRACKBAR.MAX
10 0 TRACKBAR.STEP
"calc_xor" 0 TRACKBAR.ACTION

1 TRACKBAR.SHOW
0 350 500 30 1 TRACKBAR.RECT
0 1 TRACKBAR.MIN
100 1 TRACKBAR.MAX
10 1 TRACKBAR.STEP
"calc_xor" 1 TRACKBAR.ACTION


