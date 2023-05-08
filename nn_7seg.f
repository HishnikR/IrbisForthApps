
10 CONSTANT #NEURONS
7 CONSTANT #INPUTS

CREATE X[] #INPUTS CELLS ALLOT

CREATE K[] #INPUTS #NEURONS * CELLS ALLOT
CREATE Y[] #NEURONS CELLS ALLOT

: digit0 1 1 1 1 1 1 -1 ;
: digit1 1 1 -1 -1 -1 -1 -1 ;
: digit2 1 1 -1 1 1 -1 1 ;
: digit3 1 1 1 1 -1 -1 1 ;
: digit4 -1 1 1 -1 -1 1 1 ;
: digit5 1 -1 1 1 -1 1 1 ;
: digit6 1 -1 1 1 1 1 1 ;
: digit7 1 1 1 -1 -1 -1 -1 ;
: digit8 1 1 1 1 1 1 1 ;
: digit9 1 1 1 1 -1 1 1 ;

: set-x
  7 0 do
    x[] 6 i - -th !
  loop
;

int index

: set-k // 7segs, i --
  to index
  7 0 do
    k[] 6 i - index #INPUTS * + -th !
  loop
;

: default_k
  digit0 0 set-k
  digit1 1 set-k
  digit2 2 set-k
  digit3 3 set-k
  digit4 4 set-k
  digit5 5 set-k
  digit6 6 set-k
  digit7 7 set-k
  digit8 8 set-k
  digit9 9 set-k
;


: CALC-Y
  #NEURONS 0 DO
    0
    #INPUTS 0 DO
       X[] I -TH @
       K[] J #INPUTS * I + -th @
       *
       +
    LOOP
    Y[] I -TH !
  LOOP
;

: print-x
  #INPUTS 0 do
    X[] i -th @ .
  loop
;

: print-y
  #NEURONS 0 do
    Y[] i -th @ .
  loop
;

default_k

digit2 set-x
CALC-Y
print-y

